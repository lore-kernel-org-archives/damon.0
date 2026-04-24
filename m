Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFC1AB6F1;
	Fri, 24 Apr 2026 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777073505; cv=none; b=Z3QVMLdX5oOyJd+dTK40eC3WbSDnHQ1Q3CrcfjJPMJIY0+eZVeHaQmqxivg4HpTcGuh0eQH5bqGuuz8AFiVgBELbrY+MWpyeC5+qQIeNwj75TlryRDZwqAudbtzSFEn1G2tpQlKqw7UPID5VUmiOh3+s413Y58e/BHObU5LE9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777073505; c=relaxed/simple;
	bh=BTrviosuL4nc3oB2heWGdAb/P6UmRgMsWp+GETFGUkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MG1u/VNONdBWqKgvkOyVtJZMwJcz9uxcjxCLF8mwBkKuJDFTrDZeahrO3QWyB/CyKoyMAVp8e4POaM0CUJK0bPsKnEN4d3qDh6efSjj9INY6VpOkNnwFmx9ujZ9hGt5kqbB8ONg1DtBgz2vwPRXG2GjMDid2OuxfPeOqtwDavyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA0W+LmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA0W+LmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69BFC19425;
	Fri, 24 Apr 2026 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777073504;
	bh=BTrviosuL4nc3oB2heWGdAb/P6UmRgMsWp+GETFGUkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XA0W+LmMuwGRpaGD/GJo4KrRl8+Ck93QzOgL/1SN7PG0F2sunjXGkiRUxtjRvjebc
	 f568IIPTpMWSc94Iw1W6+fekyFVx9tKvJt8CngbDyYaJPJu6OUvdh4uDXoaJW3zews
	 4mldiTA6Ji+YXhGmRDm4b1lhe52SFXOp7yzM4nGXtIqhxIy5LZ9GMtfMrUf4d4veMD
	 6UMgbiI5Y31Goix1RoYOPDy0Y/6hgRxgu3hCtaMcIaJFwBaNtm8ctN/rV+JxxgvGNj
	 qKM9tMe6Q+5QSWvdW5lBlNu8DkHrfpdedX4+UCvlQ4XErsWpSh1tiwM+5qcjeMRgAG
	 NUtpR+Z/qUlHg==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
Date: Fri, 24 Apr 2026 16:31:34 -0700
Message-ID: <20260424233136.6716-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyiikHr4doYKW5Gy4uv6M0_HbBZUSd9kM+L+kCrKYKEuXw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026 12:27:07 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Hello SeongJae,
> 
> 2026年4月23日(木) 13:34 SeongJae Park <sj@kernel.org>:
> >
> > Hello Akinobu,
> >
> > On Thu, 23 Apr 2026 09:42:06 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > DAMON currently only provides PTE accessed-bit based access check, this
> > > patch series adds a new perf event based access check.
> > >
> > > Since perf event-based access checks do not require modifying the PTE
> > > accessed-bit for pages representing each damon region, it reduces the
> > > overhead of monitoring at a fixed granularity of the page size.
> >
> > As I also commented to the previous version, the high level idea makes sense to
> > me.  I think this can be useful.
> >
> > Also as I commented to the previous version, I understand the page level
> > monitoring overhead reduction is the main purpose of this patch, and it makes
> > sense to me.  Nonetheless, I like this mainly because the perf event could
> > provide more detailed information including from which CPU/thread the access is
> > made, and whether the access is for read/write, to my understanding.  Please
> > let me know if my understanding is wrong.
> 
> That's correct.
> Once the integration into your new monitoring infrastructure is
> complete, those things will become possible.

Thank you for confirming!

> 
> > >
> > > Here is a method and its results for comparing access checks using
> > > existing access bits and new perf events.
> > [...]
> > > Using accessed bit, prepare_access_checks takes 7 seconds and
> > > check_accesses takes 5 seconds.
> > [...]
> > > Using perf event, prepare_access_checks takes 0.01 seconds and
> > > check_accesses takes 2.6 seconds.
> >
> > Thank you so much for sharing these great test results with the detailed setup
> > description!
> >
> > > ```
> > > $ sudo $HOME/damo/damo stop
> > > $ sudo $HOME/damo/damo start --ops vaddr \
> > >       --perf_event 5000 0 0x4 0x1cd 0x1f 0 \
> > >       --monitoring_intervals 5s 60s 300s \
> > >       --monitoring_nr_regions_range 1000000000 1000000000 \
> > >       --target_pid $(cat /tmp/memcached.pid)
> > [...]
> > > Note: damo's --perf_event option
> > >
> > > Using these features also requires modifications to damo, but these
> > > are not included in this patch series and are currently under
> > > development in the following branch:
> > >
> > > * https://github.com/mita/damo/tree/damo-perf-for-v3.2.2
> >
> > Thank you for sharing this, too!
> >
> > >
> > > The option newly added to damo for perf event-based access check has the
> > > following format:
> > >
> > > `--perf_event <sample freq> <sample phys addr> <type> <config> <config1> <config2>`
> >
> > I think we may need to discuss more for final interface.  But I think that
> > could be done later, after the kerenl ABI is fixed.
> 
> My current patch introduces a set of kernel ABIs (.../perf_events/<P>/*),
> and if I want to control another field in the perf_event_attr,
> I would have to add a new ABI. This would be a significant
> maintenance cost.
> 
> Instead, I would like to provide a single bin file where the
> perf_event_attr I want to set is written as binary.

I'd prefer having single file per parameter, as sysfs is designed for.  It
allows keeping the input format simple and therefore easy to maintain and
extend.  Of course, we should carefult at adding new parameters, though.

> 
> > >
> > > - `sample freq`: A higher frequency improves access accuracy, but also
> > >   increases overhead.
> > > - `sample phys addr`: specify 0 for vaddr and 1 for paddr.
> > > - The remaining type, config, config1, and config2 settings can be found
> > >   as follows:
> >
> > The values look bit human-unfriendly.  I wonder if we could use more
> > human-friendly values, e.g., 'cpu' for type,
> > 'mem_trans_retired.load_latency_gt_1024' for config, etc.  Not necessarily we
> > need to fix this right now.  Let's keep discussing.
> 
> I'd like to do it that way. These processes can be handled better
> from user space than from within the kernel, so I'd like to achieve
> this from damo with the help of the perf tool and library.

Does existing perf event ABI also take that approach?  If so, I think that is
fine.

> 
> > >
> > > Run `perf mem record -vv` to obtain the log, and then find the part in
> > > the log where `perf_event_open` was executed successfully.
> > > ```
> > > $ sudo perf mem record -vv echo > /tmp/perf-mem-record.log 2>&1
> > > $ cat /tmp/perf-mem-record.log
> > > ...
> > > perf_event_attr:
> > >   type                             4 (cpu)
> > >   size                             144
> > >   config                           0x1cd (mem_trans_retired.load_latency_gt_1024)
> > [...]
> > > ...
> > > ```
> > >
> > > The values for `type` and `config` are taken from this output.
> > > Use the values of `config1` and `config2` if they are included in the log;
> > > otherwise, set them to 0.
> >
> > The above information will also be very useful for early testers of this patch
> > series including myself.  Thank you for sharing.
> >
> > >
> > > Any feedback or advice on the patch set would be greatly appreciated.
> >
> > Again, I like the high level concept of this patch series.  I definitely want
> > this to be merged.  Nonetheless, not exactly as it is right now.  I think we
> > should spend enough time for the user interface design.  I hope the final
> > interface is long-term maintainable and easy to extend.
> >
> > >
> > > * RFC v3
> > > - drop "reintroduce damon_operations->cleanup()" as no longer needed
> > > - drop "allow user to set min size of region" (will be sent separately)
> > > - add tgid to struct damon_access_report and use it instead of tid
> > > - set perf_event_attr.precise_ip to 2
> > > - prepare for the transition to report-based monitoring
> > > - switch to use access_reported in struct damon_region
> > > - switch to use sample/primitives/perf_events sysfs directory
> >
> > Thank you for doing this revisioning.
> >
> > For the user interface and also internal interface, I suggested to consider
> > reusing those for page fault events based per-CPUs/threads/reads/writes
> > monitoring DAMON extension patch series in our previous discussion.  I think
> > this version is following the right direction much more than the previous
> > version.
> >
> > But, nowadays I'm thinking about a new user interface for the
> > per-CPUs/threads/reads/writes monitoring that can easily also extended for perf
> > event based monitoring and for not only access monitoring but general and
> > multiple data attributes monitoring.
> >
> > It is still under the development and I'm planning to share a very early RFC
> > version of that by LSFMMBPF.  I will try to add my idea about how this perf
> > event based monitoring could also implemented by reusing the interface on the
> > early RFC version.
> >
> > Could we wait until the early RFC version is published, review my idea about
> > how this perf event based monitoring could reuse it, and continue discussions
> > about the next steps of this patch series?
> 
> That sounds good. I'd definitely like to check it out.

Thank you for accepting my humble suggestion.  And sorry for making you be
delayed.  Hopefully this interface extension will soon be published as it is
one of the topics for DAMON session [1] at LSFMMBPF.

> 
> > [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org/

[1] https://docs.google.com/spreadsheets/d/1mGEdDrWskp7Ua91jGXzquQGinorcD58DAVXhOiRp2Gg/edit?gid=1852749899#gid=1852749899


Thanks,
SJ

[...]
