Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B13244687;
	Thu, 23 Apr 2026 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918845; cv=none; b=G7ONXpUhxfOGovI5OVCS8x4LL2zLdCtHYQNwUhc9ZDYKRi1KVuE77l6NHE6ybFOHNa7n7tUaZQA/3PbLHPruNFwB0/S46b/RpCM1CGNlsqtQ+rW/9yVn8EfLMMmHPIXLgBjPWW/mELQw8KWMkpQ4sb7HAjsV3tDLIs/O82RD3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918845; c=relaxed/simple;
	bh=iD0H50adZDwGWXLJOO4CRJlKJwS0xbiIeb45xY3Tau4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK79O1UKtupyW92QgU2Iim0loOvC6p1cbjztKPVSxdAc1wA6RrGUqqevShLVNhsraJe4ItCHsx0/+Nt6YRrhZUuUkByu8CH2NITBxW4yvgyPGV6KwVBgk9C3keEpHlLsnlChTG+0qVHrhUg/jKbNHy5BOa7gnMMohbxPGq5DGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlEJS9I7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlEJS9I7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44B8C2BCB2;
	Thu, 23 Apr 2026 04:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918844;
	bh=iD0H50adZDwGWXLJOO4CRJlKJwS0xbiIeb45xY3Tau4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlEJS9I76/d5S2u83ylwBcaesc3cu6tiYqfB7pPrpZTXt1s+j2eu8AB/RqNvtIKbC
	 u5/nna2CvUh1YhUBfAV8690S+1/gvwFTFUkLO6hjJFHZgTxTa8Xkf5UT5en7izBuVj
	 mnUyARcMAfn4GHe43KzHXbc8VniGpftk1KRakXwoM3lI1auMcqh8CH6UMNrMjXwKma
	 ffegpqgNyTdQudgbvi3Ue9Xko2qOdZkRFsklgM5bmjsraf14HZmU7D0ptlFIuKqlLZ
	 wM6h9LZZwLiNZicXcqgC2daWH4IocOndJALq8HislwpY86/I64sqRDY+NxAC09/oJR
	 kW7r8RCjq6t5g==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
Date: Wed, 22 Apr 2026 21:34:02 -0700
Message-ID: <20260423043402.92389-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423004211.7037-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Akinobu,

On Thu, 23 Apr 2026 09:42:06 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> DAMON currently only provides PTE accessed-bit based access check, this
> patch series adds a new perf event based access check.
> 
> Since perf event-based access checks do not require modifying the PTE
> accessed-bit for pages representing each damon region, it reduces the
> overhead of monitoring at a fixed granularity of the page size.

As I also commented to the previous version, the high level idea makes sense to
me.  I think this can be useful.

Also as I commented to the previous version, I understand the page level
monitoring overhead reduction is the main purpose of this patch, and it makes
sense to me.  Nonetheless, I like this mainly because the perf event could
provide more detailed information including from which CPU/thread the access is
made, and whether the access is for read/write, to my understanding.  Please
let me know if my understanding is wrong.

> 
> Here is a method and its results for comparing access checks using
> existing access bits and new perf events.
[...]
> Using accessed bit, prepare_access_checks takes 7 seconds and
> check_accesses takes 5 seconds.
[...]
> Using perf event, prepare_access_checks takes 0.01 seconds and
> check_accesses takes 2.6 seconds.

Thank you so much for sharing these great test results with the detailed setup
description!

> ```
> $ sudo $HOME/damo/damo stop
> $ sudo $HOME/damo/damo start --ops vaddr \
> 	--perf_event 5000 0 0x4 0x1cd 0x1f 0 \
> 	--monitoring_intervals 5s 60s 300s \
> 	--monitoring_nr_regions_range 1000000000 1000000000 \
> 	--target_pid $(cat /tmp/memcached.pid)
[...]
> Note: damo's --perf_event option
> 
> Using these features also requires modifications to damo, but these
> are not included in this patch series and are currently under
> development in the following branch:
> 
> * https://github.com/mita/damo/tree/damo-perf-for-v3.2.2

Thank you for sharing this, too!

> 
> The option newly added to damo for perf event-based access check has the
> following format:
> 
> `--perf_event <sample freq> <sample phys addr> <type> <config> <config1> <config2>`

I think we may need to discuss more for final interface.  But I think that
could be done later, after the kerenl ABI is fixed.

> 
> - `sample freq`: A higher frequency improves access accuracy, but also
>   increases overhead.
> - `sample phys addr`: specify 0 for vaddr and 1 for paddr.
> - The remaining type, config, config1, and config2 settings can be found
>   as follows:

The values look bit human-unfriendly.  I wonder if we could use more
human-friendly values, e.g., 'cpu' for type,
'mem_trans_retired.load_latency_gt_1024' for config, etc.  Not necessarily we
need to fix this right now.  Let's keep discussing.

> 
> Run `perf mem record -vv` to obtain the log, and then find the part in
> the log where `perf_event_open` was executed successfully.
> ```
> $ sudo perf mem record -vv echo > /tmp/perf-mem-record.log 2>&1
> $ cat /tmp/perf-mem-record.log
> ...
> perf_event_attr:
>   type                             4 (cpu)
>   size                             144
>   config                           0x1cd (mem_trans_retired.load_latency_gt_1024)
[...]
> ...
> ```
> 
> The values for `type` and `config` are taken from this output.
> Use the values of `config1` and `config2` if they are included in the log;
> otherwise, set them to 0.

The above information will also be very useful for early testers of this patch
series including myself.  Thank you for sharing.

> 
> Any feedback or advice on the patch set would be greatly appreciated.

Again, I like the high level concept of this patch series.  I definitely want
this to be merged.  Nonetheless, not exactly as it is right now.  I think we
should spend enough time for the user interface design.  I hope the final
interface is long-term maintainable and easy to extend.

> 
> * RFC v3
> - drop "reintroduce damon_operations->cleanup()" as no longer needed
> - drop "allow user to set min size of region" (will be sent separately)
> - add tgid to struct damon_access_report and use it instead of tid
> - set perf_event_attr.precise_ip to 2
> - prepare for the transition to report-based monitoring
> - switch to use access_reported in struct damon_region
> - switch to use sample/primitives/perf_events sysfs directory

Thank you for doing this revisioning.

For the user interface and also internal interface, I suggested to consider
reusing those for page fault events based per-CPUs/threads/reads/writes
monitoring DAMON extension patch series in our previous discussion.  I think
this version is following the right direction much more than the previous
version.

But, nowadays I'm thinking about a new user interface for the
per-CPUs/threads/reads/writes monitoring that can easily also extended for perf
event based monitoring and for not only access monitoring but general and
multiple data attributes monitoring.

It is still under the development and I'm planning to share a very early RFC
version of that by LSFMMBPF.  I will try to add my idea about how this perf
event based monitoring could also implemented by reusing the interface on the
early RFC version.

Could we wait until the early RFC version is published, review my idea about
how this perf event based monitoring could reuse it, and continue discussions
about the next steps of this patch series?

[1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org/


Thanks,
SJ

[...]
