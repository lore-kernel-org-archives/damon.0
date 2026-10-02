Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9E4973BB
	for <damon@lists.linux.dev>; Fri,  2 Oct 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946405; cv=pass; b=oGnpE/l4I1bz0sjPqkUU1xf9ENCBcokKd7VO6xmRY9eNv6yCWauD4dtFKbVUJSHbOXNCdTYHyvC1ShDux1epNB7ZFYUBigSstra0lDOW9tbbOYJlN0CkXAaGIVQj0paBI0Ygz5SA7vcbZb6f5aazoxDQsqBs+ukh4XhXHPzD2/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946405; c=relaxed/simple;
	bh=7e/mWyT1RfG7j9nauEU9s0UidVI8XH2Q/IYgYB+myKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqtjcKgbMit8XDqfuzQcdKD2ql/C7kiifqjB1PaJnkGBmDxz2LNtsF9y6+MGqN63ZnY5sZXaE66ax0411Qfm9rSpomQspr0po/kl8sjKh4xB3Zbwrco2YDwXalKrx3KFzB52dj4lEIqrq7c+PTKQJEpQJSqA4F90Iu7147irdE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFS+b6nY; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFS+b6nY"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae42b3e901so1502314a12.0
        for <damon@lists.linux.dev>; Fri, 02 Oct 2026 06:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790946391; cv=none;
        d=google.com; s=arc-20260327;
        b=asCADYljfA/y1x04+l6vfHr2WnmRsquCwPBSOYYw+hYo85nGdmByHNLi2QKuX5hHD4
         wB+Pa9F9hPTVzLeLSAv4js0NpOd691E1/iIpkUKzujOZ7cPSPMQK2JsO6djrM+OcbFqG
         rQJFwYBl7cGKARxUe+NuTdgS1lVD4aojGACwEsRl9NG8FLueyCp7o0K8hLyWOg1i8nnS
         JUh4NYlTkXReEcRzmo7tUMEmUbdeHCDfnWdXAhoOwax8uamLtcTp6akMEi4VOZhCREar
         hW5J/hAhE8CuYxoLDjMqPw3oKF36edgNsUiOhVpHEGE+bBtGpYCyBzpJdPeFLV0fP4PO
         +Hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kj59RtyWfzcu08/lJKWrw4pDMZz16oiwR3Kfv4e3oew=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=KrsqLzslxLtjZqIeadhJkmfb6v/CqH4twidV3qZHtt8XrWuj28E3b9X3aaoKgzow/j
         NVl9ZWQoFAM/bKtaSTVCuETVWNYUm35S3pMVCIHdo/5yVlivRERRwqICreCU+I4G3PMD
         i85pvLWKUmBaD5MuEgnCWSY1OFLwGMrOc6GqzZ6N/w2HUidvNZkpG5q7bkezYEXHOvsf
         cGD7nMAbMtGdO1n5tEJAOvGGXW3xAxqDSh2Lwv2PtkJEfH5YisNA2aFHCBJDYCoFTJ+p
         8d+ELZlBj156MQ2hA+YoTu6l5DIHEd20/N4VHcJ7vuSz4P/DIZl8bpOPeWhkL0CQnXbC
         9RCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790946391; x=1791551191; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kj59RtyWfzcu08/lJKWrw4pDMZz16oiwR3Kfv4e3oew=;
        b=oFS+b6nYKXjZLqwkiwRRb9LP4OAaYg7Fyqln2nOlIBEdBjWsxt4JI2hdo+C+7qnflD
         5IPOJJ8lJrhisppFiMTCsbs1o1hGvJSuE0PTssX7/AEXET6pTerw5aAh+pwAgcVSQXfb
         KhVu7jnksoAJhl71oE8Wu5ulrNJVuykC7+osPztOlGIsEahtsKbZlYD4euzR2hKt5Ir+
         xg+12lzrcu8PATbh6UBqf0n84+OLMoQ55i/8dFX8a6BA8gIkgnHYkIhwg6WsqT1vsC+3
         omt5MdAOEPoJ/RaqBNFDiz3ly04YNX5aAnXsXjy29yUBwfYbpJwcV6uGbkL9qNq++pjO
         +yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946391; x=1791551191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kj59RtyWfzcu08/lJKWrw4pDMZz16oiwR3Kfv4e3oew=;
        b=TKf5fFFXnNFT2Fx4i0UUbFwlttpIEyV+ZXUKfUB41AVa4Jc+bUGP+JC71PQvv8DCfa
         brE4oMNhrdB4nnA8xlL3c25SX3ZRfql08kqScQ9L/Hlzi1xX+WAKEu/yZRVXtVYlo27T
         LYqH5kwsZB+JvxaSE4m/Wna4/JDb9WDgA8nOeex8jTFocKOUA6pNjvvBTas2Zt1m7q7O
         LyBgnBe0Hc7EVzLsmARUrhXOE/JAkfLpLwLSFCkx5SbgMceMjq/tjfusf531bq0I4BEt
         NJtJBXm7dvJU2qtZGffaeS/cHv+XNOZWgmzzms+voip8Xv/NJ3Gxkiw/+atr+t7ZV74q
         3eMA==
X-Gm-Message-State: AFq9FYLNe5HYNkKZtKBXhY5B4/KSafmhtChVaenO2vStVbcXwdBwBh0S
	51GZhbGViTEAyLQoI5wfI3A9Ff2pLQD+9dnvjYMzzVp8CYE+i6mjDs/H6ibJfel6ZCsxAOYU6hB
	jJxlhZb0W8hVp1Ex769KalCcLAYXDsvfmI39M
X-Gm-Gg: AYBFou1UwyV7/XvBLhIJuqsH96EodE+ct+eQMUkfCm0o64cZ6AZWmSJI0FeFaf0bZkO
	dSCaQOHyVGwxNhqjl47qgwHSHWzamSV+s2rwg7gDZMmJR3SKh6Y7vIwFC0VmPg8GA5BzHK1xLDF
	b4R88ewrM+PA57Fe8LSfoGQHzWpL3qyuY+lNNZjiAZKvGlfVs6uQA8BWvYTXVvVlaaKH85Zh/o6
	0MyfeaS5Wmlc2MfYJCi1CCYUZ0FyikqIdCCXSwi7pEsGJzk6dZqx2dirsXqrd5gCUW5QJ4vjoED
	wDFt7i3u0EnJ5UcinZHRFI7FkotdU3AehB8NVZlOUonmHJcHsuRXbcFKErw1LahgfQi6
X-Received: by 2002:a05:6402:4018:b0:6ac:6d97:c5f7 with SMTP id
 4fb4d7f45d1cf-6af9e320df9mr1853935a12.17.1790946389124; Fri, 02 Oct 2026
 06:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjpBdRQnmsm8zB-Bh7taeBkOPadhQWOk6-a2dfTxYVMiZw@mail.gmail.com>
 <20261002110216.41169-1-sj@kernel.org>
In-Reply-To: <20261002110216.41169-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 2 Oct 2026 16:06:17 +0300
X-Gm-Features: AclHuK871J4z_KgtDqQbNHuQNJ2Fi8deI8qKGhkrfNbkCf1uTObfwCcKuKgO2qU
Message-ID: <CAAiJnjo9qA8SNFyjG3dJfX7ZF2GPMAdNe2FoCJGABu9HZaKs7w@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> For example,
> let's suppose 10 GiB data of a workload becomes hot, but will be cold aga=
in
> after 10 seconds.  If we can migrate it to upper tier in one second, it w=
ill
> get benefit from continued access for remaining 9 seconds.  If it takes 1=
0
> seconds to migrate, the benefit from the migration will be much lower.  I=
t
> might even lower than the migration work cost.

Exactly right.  It fully matches the requirement to improve the
current 1.4 GB/s migration bandwidth.

So based on our discussions, I will try to discuss that with Memory
Management subsystem maintainers.

Anton

=D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 14:02, SJ P=
ark <sj@kernel.org>:
>
> On Fri, 2 Oct 2026 13:02:13 +0300 Anton Gavriliuk <antosha20xx@gmail.com>=
 wrote:
>
> > Peak sequential write to slower tier ~12 GB/s.
> > I set the upper limit 8 GB/s just to keep those PMEM modules not overlo=
aded.
> >
> > For Memory Tiering with OLTP-like workloads needs to be
> > promoted/demoted, 1.4 GB/s is OK.
> > But for bandwidth intensive workloads such as analytics, AI, VDI,...
> > 1.4 GB/s is too slow.
>
> I think the factor deciding how fast migration should be is not bandwidth
> intensiveness but how quickly access pattern changes.  That is, migration=
 speed
> should be fast enough to get costs from migration itself be paid back, an=
d get
> additional benefits.  That depends on the speed of the workloads' access
> pattern change, and the amount of data of the changed pattern.  For examp=
le,
> let's suppose 10 GiB data of a workload becomes hot, but will be cold aga=
in
> after 10 seconds.  If we can migrate it to upper tier in one second, it w=
ill
> get benefit from continued access for remaining 9 seconds.  If it takes 1=
0
> seconds to migrate, the benefit from the migration will be much lower.  I=
t
> might even lower than the migration work cost.
>
> >
> > On the server where I test Memory Tiering, Intel CPU 8280L installed.
> > Despite being already 7 years old, any single CPU core has 13-14 GB/s
> > bandwidth access to local memory.
>
> That maese sense to me.  Kernel level page migration requires not only th=
e
> content writes.  It also need to do additional works.  It should allocate=
 pages
> in destination node that the content will be copied to.  It should update
> mappings and related metadata.  It should also handle possible races.  He=
nce
> page migration is much more expensive and slow than pure I/O.
>
> >
> > So from my point of view - even if we increase the number of cores
> > keeping in mind 1.4 GB/s per core, we need so many cores to perform
> > 10's GB/s demote/promote.
>
> I agree.
>
> > Firstly we need to improve demote/promote
> > bandwidth for single CPU core, from 1.4 GB/s to at least 9-10 GB/s.
>
> I agree there could be workloads that could get benefit from faster migra=
tion.
> And IIRC, there were a few people working on making migration faster and
> lightweight.  I'm not an expert in the domain and not involved to such wo=
rks
> for now, though.  Nonetheless, having concrete data showing why 9-10 GB/s=
 is
> the right speed would be nice.
>
> >
> > > You could also confirm
> > > this by measuring the migration speed using move_pages() like system =
call,
> > > which also use the migration code.
> >
> > I'm not a developer and I need to spend more time thinking about how
> > to do that, but I tried,
> >
> > I used migratepages command, which is probably use migrate_pages()
> > instead of move_pages(), but I got the same poor bandwidth and stack
> > as with DAMON/DAMOS Memory Tiering,
> >
> > top - 12:43:59 up 13 min,  2 users,  load average: 0.65, 0.88, 0.76
> > Tasks: 757 total, 2 running, 755 sleep, 0 d-sleep, 0 stopped, 0 zombie
> > %Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,=
  0.0 st
> > MiB Mem : 6839822.+total, 6438483.+free, 416313.2 used,    669.8 buff/c=
ache
> > MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6423508.+avail =
Mem
> >
> >     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ =
COMMAND
> >    2935 root      20   0    2644   1764   1644 R  99.7   0.0   0:42.19
> > migratepages
> >    2941 root      20   0   10884   6192   3916 R   0.7   0.0   0:00.04 =
top
> >    1238 systemd+  20   0   15860   6996   5952 S   0.3   0.0   0:00.37
> > systemd-oomd
> >    1928 root      20   0  666268  24448  23440 S   0.3   0.0   0:00.34 =
rsyslogd
> >       1 root      20   0   25840  15532  10492 S   0.0   0.0   0:02.15 =
systemd
> >       2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 =
kthreadd
> >       3 root      20   0       0      0      0 S   0.0   0.0   0:00.00
> > pool_workqueue_release
> >       4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> > kworker/R-rcu_gp
> >
> >
> > |---------------------------------------||-----------------------------=
----------|
> > |--            System DRAM Read Throughput(MB/s):        759.41
> >         --|
> > |--           System DRAM Write Throughput(MB/s):        751.36
> >         --|
> > |--             System PMM Read Throughput(MB/s):        701.24
> >         --|
> > |--            System PMM Write Throughput(MB/s):       1402.15
> >         --|
> > |--                 System Read Throughput(MB/s):       1460.65
> >         --|
> > |--                System Write Throughput(MB/s):       2153.50
> >         --|
> > |--               System Memory Throughput(MB/s):       3614.15
> >         --|
> > |---------------------------------------||-----------------------------=
----------|
> >
> >
> > Samples: 92K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> > 48280162400 lost: 0/0 drop:
> > Overhead  Shared Object                      Symbol
> >   49.82%  [kernel]                           [k] migrate_folio_unmap
> >   16.52%  [kernel]                           [k] clear_highpages_kasan_=
tagged
> >   13.56%  [kernel]                           [k] copy_mc_fragile
> >    1.80%  [kernel]                           [k] smp_call_function_many=
_cond
> >    1.06%  [kernel]                           [k] page_vma_mapped_walk
> >    0.95%  [kernel]                           [k] try_to_migrate_one
> >    0.94%  [kernel]                           [k] folio_migrate_flags
> >    0.71%  [kernel]                           [k] rmqueue_bulk
> >    0.61%  [kernel]                           [k] remove_migration_pte
> >    0.54%  [kernel]                           [k] __free_one_page
> >    0.50%  [kernel]                           [k] migrate_folio_move
> >    0.48%  [kernel]                           [k] folio_batch_move_lru
> >    0.47%  [kernel]                           [k]
> > __list_del_entry_valid_or_report
> >
> >
> > Samples: 37K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> > 33608407521
> > migrate_folio_unmap  /proc/kcore [Percent: local period]
> > Percent =E2=94=82       movq   %r13,0x20(%rsp)
> >    0.02 =E2=94=82       movq   %rdx,%r13
> >         =E2=94=82       movq   %r14,0x28(%rsp)
> >         =E2=94=82       movl   %r9d,%r14d
> >         =E2=94=82       movq   %r15,0x30(%rsp)
> >    0.01 =E2=94=82       movq   %r8,%r15
> >         =E2=94=82     =E2=86=92 callq  *%rax
> >    0.04 =E2=94=82       testq  %rax,%rax
> >         =E2=94=82     =E2=86=93 je     2e3
> >    0.01 =E2=94=82       movq   %rbp,0x10(%rsp)
> >         =E2=94=82       movq   %rax,%rbp
> >    0.03 =E2=94=82       movq   %rax,(%r15)
> >         =E2=94=82       movq   $0x0,0x28(%rax)
> >   99.52 =E2=94=82       lock
> >         =E2=94=82       btsq   $0x0,(%rbx)
> >    0.01 =E2=94=82     =E2=86=93 jb     26b
> >    0.13 =E2=94=82 67:   movq   (%rbx),%rdx
> >    0.01 =E2=94=82       testq  $0x2,(%rbx)
> >    0.01 =E2=94=82     =E2=86=93 je     e2
> >         =E2=94=82       cmpl   $0x2,%r14d
> >         =E2=94=82     =E2=86=93 je     d2
> >         =E2=94=82       movq   0x40(%rsp),%r8
> >         =E2=94=82       movq   %rbx,%rdi
> >         =E2=94=82       movl   $0x1,%ecx
> >         =E2=94=82       xorl   %edx,%edx
> >
> > Lastly I used migratepages between two fast tiers (numa nodes 0 & 1)
> > and got 1.5 GB/s.
> > All this is too slow for the coming CXL era.
>
> Thank you for testing this and sharing the results.  This confirms my pre=
vious
> theory is not wrong.
>
> >
> > Anyway, I'm ready to proceed in assisting you in checking/testing if
> > you are also interested.
>
> I think my thoery (bottleneck is in migration, not DAMON) is already prov=
en.
> We also confirmed DAMON and DAMOS are working as expected so far.  So I f=
ind no
> more thing to test for now.  If you have more ideas to test, I will be mo=
re
> than happy to help.
>
>
> Thanks,
> SJ
>
> [...]
