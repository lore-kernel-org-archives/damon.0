Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9C274670;
	Thu, 17 Sep 2026 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605942; cv=none; b=jmX6f9KODsgceK7/olACpWO4ZltSx+/DnTF/eA5Tbt1cjTIlXLzkUm1/wUnoTtGu+HzhX5fvHV/Ce3qOyW87cFK9rbjroqnlK1t2hT4JGOVy8Og0wCW2Q/rl3rQtJwMKQREU5rX3K5ogm8R7TlYplfdBR1AHhggTIVMtPVcleo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605942; c=relaxed/simple;
	bh=7Z3vIBjt5tLPRNBuQBru3f1/VsY4t+8DZAWOPwWqtcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8+D4T0UWqnWyG5ULFTKnwfEWLHZVu64odWAh6Zk95aOKmdxnuPQzyUpRnJIpuHcCWdKm54DJoFNkynGwCNs22uBmXcH0QXRdHYJQ6UyxmEjYNqZK+7XhPzKUEn4OqfQtynVda6gLYVwcpojNC+ICNOxFlYlcJOF8aCRUfG+YfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeoNV/Yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeoNV/Yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AFC1F000FF;
	Thu, 17 Sep 2026 00:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605940;
	bh=RvTeJmFNZPYMWT61qKcfcgq1L4fEWGELOp4BeELaDsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeoNV/YontnZ41uoAbstSo7w3oewrxMhH9IUG0/JJWsuxlognqRKhtvFsaRmAeyI2
	 +7k7eV7VIHil2XyDImur2sVzI2S0p16+nkC1305mipjW1ylsIwmdcaUssQxwQMcFLD
	 pW/LdMyVWzrVuKG+tZGQWh+s8SuR7r6nT+qo5lsVihhFylOinaWe5zIYl0qlOPjO2J
	 LakPAMgbsRnVPqgYM3scZvGsEKNl9RggWtFr4XaNG/JJNWGdXzSVSELhY9DiZ7Zbup
	 tdaul1b+4PlK9iu3J7x0snqyVFYmTDBw9sXBcmh3VXg/poWhKsrvtoctpXDyWZy4z3
	 pVqhIiz2nNdbA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: DAMON reporting more hot memory on huge pages (was: "Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports")
Date: Wed, 16 Sep 2026 17:45:32 -0700
Message-ID: <20260917004533.89744-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916051150.107931-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 22:11:49 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed, 16 Sep 2026 11:44:30 +0800 "Lian Wang (ProcessMission)" <lianux.mm@gmail.com> wrote:
> 
> > Hi SJ,
> > 
> > Thank you for the questions.  I mixed the original field scenario and our
> > controlled reproducer in my previous mail.  I also jumped from the observation
> > problem to PMD mapping demotion before explaining why the deployment needs both
> > huge pages and finer-grained observation.  That made it sound as if our goal
> > was simply to stop using huge pages.
> > 
> > > The observation makes sense.  However, does the sparse access pattern
> > > realistic?  If so, what is the purpose or expected benefit of using huge page
> > > for workloads having such access pattern?
> > 
> > The original case is not a lab-created request to use huge pages for a sparse
> > microbenchmark.  It was reported by SXF from a KVM/QEMU deployment where the
> > VM has a large memory allocation backed by a shared tmpfs file, host THP is
> > enabled, and Oracle runs inside the guest.  They use host-side DAMON to measure
> > the VM's hot-memory proportion.  With the same business memory use, they
> > observed a much larger hot proportion when THP was enabled.
> 
> Thank you for clarifying this.  So I understand it is an issue from a real
> world workload.  I'm still curious how sparse the real access pattern in the
> real world workload is, and if there is a low haning fruit.  There might be
> rooms to improve in their DAMON usage.
> 
> Could you share more details about the real world setup and findings?  More
> specifically, how they define the hot proportion and how they collect the
> number?  What is DAMON setup?  What are the real numbers they saw?
> 
> Also, I understand they want to understand real working set size of guests.
> Could you further share what they are planning to do with the monitored working
> set size?  The required level of accuracy of the monitoring could depend on the
> purpose.
> 
> > 
> > The guest tmpfs 4 KiB/2 MiB writer is their controlled diagnostic case for
> > isolating that observation; it is not a claim that the Oracle workload is
> > exactly a one-page-per-2-MiB loop.  We then reproduced and quantified the same
> > effect on a PC and on the x86 server.
> > 
> > For this deployment, keeping large pages is a real requirement at the host
> > virtualization layer.  QEMU owns a large resident guest-RAM mapping.  Host THP
> > allows that mapping to use PMDs and allows KVM to use large secondary mappings,
> > reducing host page-table memory, TLB and nested-page-walk pressure, and KVM
> > mapping/fault overhead.  These benefits are independent of whether every 4 KiB
> > page inside a particular 2 MiB range is hot at one observation time.
> 
> Thank you for clarifying this.  Now I understand why they use THP, and I fully
> agree they should keep using THP.
> 
> [...]
> > The performance requirement and monitoring use case come from the deployment,
> > not from our lab model.  We will also report the measured Oracle/VM benefit and
> > the production access distribution when those data are ready.  The diagnostic
> > result establishes the observation mechanism, but it should not substitute for
> > those workload-level measurements.
> 
> Thanks to your detailed and nice explanation, I don't doubt about the needs to
> use huge pages.  So I wouldn't insist on Oracle/VM benefit from huge pages.
> 
> I'm still curious the real access distribution, though.  I understand you don't
> have the data yet.  It would be very helpful if you could share that in future.
> 
> > 
> > > I'm not very sure if this is the right direction.  PMD mapping demotion sounds
> > > like you just don't want to use huge pages.  If so, you could disable huge
> > > pages.
> > 
> > I agree.  My reasoning in the previous mail was too jumpy: I went from a coarse
> > observation directly to a possible MM response, and that obscured the actual
> > goal.  PMD mapping demotion is not part of our current proposed solution.  The
> > current direction is to keep both the huge folio and PMD mapping unchanged and
> > use a genuinely fine-grained access primitive to improve the observation and
> > the stat-only decision.  We should first find out whether that is sufficient
> > before discussing any mapping change at all.
> 
> Thank you for clarifying.  Yes, if you really need sub-pmd access, I believe
> the perf event based DAMON could be more useful.  Nonetheless, as I requested
> above, knowing the DAMON usage and purpose in more detail might let us finding
> a low hanging fruit.

I still want to better understand the real world use case before digging into
the specific solution.  But, I was thinking perf event based monitoring might
not feasible for the case.  If that's the case, I think extending data
attributes monitoring for splitting pmd mapping be fore the access check might
be a path forward.

That is, we can request DAMON to do some preparation action for the data
attribute sampling, using damon_prep.  At the moment, set_pgidle prep action is
supported.  Maybe we could add a new prep action, say, split_pmd?  Then, the
following sampling memory access check probe (would be a kind of "allow
pidle_unset" probe filter) will be able to show the access on exactly the pte
accessed bit, not the pmd accessed bit.

Breaking pmd would cause the overhead, but it would be capped by the
max_nr_regions.  So the user could at least consider about the tradeoff.  I
think this is simpler and more intuitive than DAMOS-based pmd breaking, at
least.

> 
> [...]
> > With this context clarified, we will return to the immediate work: use the
> > existing IBS/perf-event proposal as the concrete strategy under test, and see
> > whether its fine-grained evidence can improve the observation and DAMOS
> > decision for this case.  We will use the results to test and review this series,
> > report both improvements and remaining gaps, and not assume in advance that it
> > is the final solution.
> 
> That makes sense.  Because Ravi thankfully already implemented this nice
> working version prototype, there is no reason to not test it right now.
> 
> > 
> > I hope this clarifies why keeping huge pages and requesting finer-grained
> > observation are not contradictory requirements in this case.
> 
> Yes, it is now clear to me.  Thank you for patiently englightening me, Lian.
> 
> > 
> > If I am still misunderstanding any part of your questions, or if any part of
> > this explanation remains unclear, please continue to correct me.  We will keep
> > sharing our findings and would like to make sure we are aligned before going
> > further.
> 
> I believe testing the perf event based monitoring with Ravi's implementation is
> a good path forward.
> 
> I'm curious about the real setup and results your clients got from their real
> world wokload.  But that's not necessarily a blocker of the perf event based
> monitoring test.
> 
> 
> Thanks,
> SJ
> 
> [...]


Thanks,
SJ
