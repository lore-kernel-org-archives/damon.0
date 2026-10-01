Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A22BE034
	for <damon@lists.linux.dev>; Thu,  1 Oct 2026 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873664; cv=pass; b=eD4HSoUF5Be51jNbHPc3QLnmBowG8bPw/+hFrGf0FAb/umFdeNfSa7Lja2kkCJJu49Bi2h/B7CLRDq8qesx5gAhjrmuzFv9uzRI4BmsZZmCogvzwrt3FGNOzOSxWb7VjHi2VHflzDGgYuZuVR6qchsNEzF/qPFJzY8aWcAHKPAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873664; c=relaxed/simple;
	bh=0KzgbUC5MAXGCBAcgqyYDa8Djaifizc02Xgr1LWBzx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOhhqi5nJnpbKEsh67CZZEyYRvtZUK1/akz5QJALNmm5X26eMmHvwLvdlwb4uX8bAPAdkSedJNikSknzAvTUXJifStRYiJQiEZjdWKx8g7J2q8GjhxwnMYKHJSDPveyqUe/Vwr2Vm0aei54asmYfClebCFgKd8FXWHQbjTBNZ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJjfmu8v; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJjfmu8v"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6af7e6620c4so1095087a12.1
        for <damon@lists.linux.dev>; Thu, 01 Oct 2026 09:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790873661; cv=none;
        d=google.com; s=arc-20260327;
        b=lV9zRwBFMbBChwFWR6k1shMJ4E3oFZ8liOSUhsV8EYVjMvRRlFYNon0ub3Av06H1Nj
         9FtWZh+VPqm6nTg9fZhWZSNYKN5BmIMZDF7z9PSl4EsTdKzSeHwpvMGiNjWQ17U+XMKE
         ToCOjnsqDd4La02ligj9K5EhK5xcRi3hEecefspEMxxjgS2At+T/M5tjgQqg+BXQimqK
         bni8hg8QL2yQ/3zoiho3KZwquex6SZwo5xaNQ/NKYv4US73kuOjgyZfOc6CY4iZBTI9O
         TkAy+Qg1HWRsSTTkqiarSY1wrkWunC5AZiXgMN4yoLUnD2YPMCYnus0yQCM/wzCbQ3GF
         qT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5VZTry/hdLScZlYsVZsvSiYT2nXe59R1xn5s42nLvmU=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=D04rLgEwyfCBBMU4R2BtcfCOopv7fXXrKUfD5or6nBHjf/M1mfT0c5MmhCGGmCQzwu
         5dqm+dllX7PeO3U0VDzus7sYt8LfM7fqcWCaSsUmW1fAml6jIyl0B8HI4tNaB/7Ph9CM
         mBRTj0MVkABrv/Cp8HuzR3yzKKNjLX+c14+ZonWHqoVk7mq87Cn/u1VMg9xtch0oDhSQ
         XDBP2IbIiQBJK7JR/rJvltJC3OnE6JBvq7/ZXG2M2li+y4FZXYT1v0xbMIei/cusGhwW
         Xy336Cildb/+gUeAOXTnpjqRX0+v+iEOS91BgIjqO8GcGQQHFUttgHx1oeXXnJdzQ7zJ
         O2uw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790873661; x=1791478461; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5VZTry/hdLScZlYsVZsvSiYT2nXe59R1xn5s42nLvmU=;
        b=bJjfmu8vR2Q0kXQswey0hvXwIXj3Pyy4YU/U2SiyfpNFq+BiCpPz0lRJygIdag0YEi
         hwxD5aGx5ZZUFqEFSTmvYllailEuNl7gQbuE+qqxB+0L7yOWzFGXfjPlKki1YTeRsT1h
         9qJOyUk+vsZyYEzeOa8sKKtgohmD/oIw6+Bo2PZfODX1sbI25H33vevzXlhv1Oyr46cV
         nDzkg08wLg43WDGsgYIQ6CBMtEefF7wrAFL2kA9IejercgRnfL6Rv/lY/yjGG0O0J641
         H2Ia9Pjvb76SORVlnINIECmakFpLX0N4tc/9K/WgedZEgofQKWOPk2SNOnk9eaTaQr4E
         mXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873661; x=1791478461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5VZTry/hdLScZlYsVZsvSiYT2nXe59R1xn5s42nLvmU=;
        b=FKUQjgjAzhULaHGKjcsNDGvw6gyhHZ5CE1MGVrFvCSLj6TbjpdBAQqbm8xlk5pEeag
         H5uMi+xDr4FLzRQr6t9wxTjYNztGhCiEfdbCC7KpMIXS79wTAlEFACGwJOaxvPGn8lxk
         YQVLXoYZWDI5KUVrVLRSyVt1b6dHQrrVNPMzc8CmR3cWyKn4/KnPSxaWbHpFHNxxu9ws
         AW3N3XQrs8YaP1sQAhdUWZJXDj3/f6CbDtGnTl4cp+S2CaRGR6jDMDwXP++mlWuVb+fp
         dua+Kzqk1QtHcVAf/gT7A/vPQ3j1tmCZ+4XQi8aNxtq7/g3OTmFunLkIlYQOoOiVXdw8
         3Cag==
X-Gm-Message-State: AFq9FYKyRkVbMe1ftXYQB9MaLm7gKRu6ptAwdxUzOu4oAemlwvy9IQgl
	KfiVrtbF16I0SAu0NSHt6tzUkGgKT7UNF57hsnManVXDxE5Cokvw4hOIjX91o3muTENhRiLwJwB
	WKsGDSfq/sEqJt2Wld4RSyb+fupmZ/jV+1Hjl
X-Gm-Gg: AYBFou2RQwFvdHb5VTu/Cz03hv9gSsuyDwT3T68Z0RI7/yHvA2Xazvf31TzpwQ9xtSG
	XW8h/lI/hVfDRdbf/3L4FBRkKbsbSREgj427LEjrhc+yrCvj7SV6njloTWqp9XeoimfM5EBILZz
	zocdpr5p8b0Ow0Y7CtBhX9w0bdaDqnLlip4dlsLQsS2/y66KVaovRBsDD8i4NoKEHNTnzAvv5Hx
	677xmxvhVFvjHPHPWX9ndciCQ2hWnSihtMQBT7J9hKkQZiUD6aJ2IwZ7XilHhTZgjcqlh0HXScS
	GtY8fY5PCP9gPUpHJt16dexC42KIut2HcsF0dqrfBVaVjqRxIoTCUUslZ19tSlp7o8jB
X-Received: by 2002:a05:6402:320f:b0:6ac:62aa:e3dc with SMTP id
 4fb4d7f45d1cf-6ae19925adfmr4257404a12.26.1790873660498; Thu, 01 Oct 2026
 09:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjp40164tbVXhJ9rP4J0UP9m9r4_Zo2phBvQ64pCzpxS7Q@mail.gmail.com>
 <20261001132755.47167-1-sj@kernel.org>
In-Reply-To: <20261001132755.47167-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Thu, 1 Oct 2026 19:54:09 +0300
X-Gm-Features: AclHuK8UWkAmsJ5IdwCWJ6dcThQ6XvYLdQZ37LN4RoGnhDNB0mySR86HZ5OGCeM
Message-ID: <CAAiJnjpweWDACdt3HKtup=8Byp00ePakcHJWEY=WdGT7MT6yxA@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> That said, I'm personally curious if such fast migration is really needed=
 in
> the real world workload.  I assume the real production workload would hav=
e
> stable access pattern but only occasionally get access pattern changes.
> Sometimes temporal and rapid access pattern change could also be made.  B=
ut for
> such temporal pattern change, doing migration would only be costy, since =
the
> data that suddenly hot could be soon be cold.  And reliability is importa=
nt in
> production.  Hence I was thinking slowly making the balance is better tha=
n too
> quickly and reactively making migrations that will turn out to be no real=
ly
> needed.

> That said, if you want to test faster migration speed, the multiple kdamo=
nds
> usage could be one way to test.  If it turns out it is really needed and
> splitting address ranges has problems, we can consider adding DAMOS featu=
re for
> utilizing multiple CPUs for faster migrations.


I agree with you!, but now it looks that demotion is too slow.
The server is completely idle, only I play with memory tiering.

As CPU-less NUMA nodes I use Intel Optane PMEM configured as DAX devices,

[root@localhost anton]# ndctl list
[
  {
    "dev":"namespace1.0",
    "mode":"devdax",
    "map":"dev",
    "size":3183575302144,
    "uuid":"865e9ee4-6334-4094-ac56-8b452bf4f53f",
    "chardev":"dax1.0",
    "align":2097152
  },
  {
    "dev":"namespace0.0",
    "mode":"devdax",
    "map":"dev",
    "size":3183575302144,
    "uuid":"ce77e90e-31bd-4057-8076-1f5d4374e9a2",
    "chardev":"dax0.0",
    "align":2097152
  }
]
[root@localhost anton]#

and then configured as system ram by next command,

daxctl reconfigure-device --mode=3Dsystem-ram all

The problem is during demotion (to keep 25% free in the fast tier),
kdamond.0 utilizes single CPU core ~100%, but writing to the slower
tier (System PMM Write) ~1.4 GB/s what is much slower than defined
limit 8 GB/s.


top - 16:26:06 up 12 min,  2 users,  load average: 0.81, 0.75, 0.54
Tasks: 765 total, 2 running, 763 sleep, 0 d-sleep, 0 stopped, 0 zombie
%Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.=
0 st
MiB Mem : 6839822.+total, 6439081.+free, 415816.0 used,    465.2 buff/cache
MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6424006.+avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND
   3227 root      20   0       0      0      0 R  99.8   0.0   1:28.92 kdam=
ond.0
   2771 root      20   0 6932852  10260   5608 S   0.7   0.0   0:02.95
pcm-memory
   1593 root      20   0   17088   8352   7140 S   0.3   0.0   0:00.99
systemd-logind
   2263 root      20   0  300.4g 294.4g   6108 S   0.3   4.4   4:42.72
valkey-server
   3327 root      20   0   10916   6064   3764 R   0.3   0.0   0:00.16 top
      1 root      20   0   25356  15232  10456 S   0.0   0.0   0:02.13 syst=
emd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthr=
eadd



|---------------------------------------||---------------------------------=
------|
|--            System DRAM Read Throughput(MB/s):        751.95
        --|
|--           System DRAM Write Throughput(MB/s):        742.58
        --|
|--             System PMM Read Throughput(MB/s):        693.12
        --|
|--            System PMM Write Throughput(MB/s):       1387.47
        --|
|--                 System Read Throughput(MB/s):       1445.08
        --|
|--                System Write Throughput(MB/s):       2130.05
        --|
|--               System Memory Throughput(MB/s):       3575.12
        --|
|---------------------------------------||---------------------------------=
------|



Samples: 111K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
51312892466 lost: 0/0 drop
Overhead  Shared Object                      Symbol
  47.50%  [kernel]                           [k] migrate_folio_unmap
  16.11%  [kernel]                           [k] clear_highpages_kasan_tagg=
ed
  14.93%  [kernel]                           [k] copy_mc_fragile
   1.63%  [kernel]                           [k] smp_call_function_many_con=
d
   1.44%  [kernel]                           [k] page_vma_mapped_walk
   0.97%  [kernel]                           [k] folio_migrate_flags
   0.87%  [kernel]                           [k] try_to_migrate_one
   0.66%  [kernel]                           [k] rmqueue_bulk
   0.61%  [kernel]                           [k]
__list_del_entry_valid_or_report
   0.59%  [kernel]                           [k] remove_migration_pte
   0.50%  [kernel]                           [k] rmap_walk_anon
   0.45%  [kernel]                           [k] __free_one_page
   0.44%  [kernel]                           [k] migrate_folio_move
   0.44%  [kernel]                           [k] folio_add_anon_rmap_ptes
   0.40%  [kernel]                           [k] lru_gen_add_folio
   0.40%  [kernel]                           [k] __mod_memcg_lruvec_state
   0.39%  [kernel]                           [k] mod_node_page_state
   0.35%  [kernel]                           [k] migrate_pages_batch
   0.33%  [kernel]                           [k] _raw_spin_lock
   0.33%  [kernel]                           [k] up_read



Samples: 222K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
64449579226
migrate_folio_unmap  /proc/kcore [Percent: local period]
Percent =E2=94=82       movq   %r13,0x20(%rsp)
   0.01 =E2=94=82       movq   %rdx,%r13
        =E2=94=82       movq   %r14,0x28(%rsp)
        =E2=94=82       movl   %r9d,%r14d
   0.00 =E2=94=82       movq   %r15,0x30(%rsp)
   0.01 =E2=94=82       movq   %r8,%r15
        =E2=94=82     =E2=86=92 callq  *%rax
   0.16 =E2=94=82       testq  %rax,%rax
        =E2=94=82     =E2=86=93 je     2e3
   0.01 =E2=94=82       movq   %rbp,0x10(%rsp)
   0.01 =E2=94=82       movq   %rax,%rbp
   0.04 =E2=94=82       movq   %rax,(%r15)
   0.00 =E2=94=82       movq   $0x0,0x28(%rax)
  99.27 =E2=94=82       lock
        =E2=94=82       btsq   $0x0,(%rbx)
   0.01 =E2=94=82     =E2=86=93 jb     26b
   0.11 =E2=94=82 67:   movq   (%rbx),%rdx
   0.01 =E2=94=82       testq  $0x2,(%rbx)
   0.01 =E2=94=82     =E2=86=93 je     e2
        =E2=94=82       cmpl   $0x2,%r14d
        =E2=94=82     =E2=86=93 je     d2
        =E2=94=82       movq   0x40(%rsp),%r8
        =E2=94=82       movq   %rbx,%rdi
        =E2=94=82       movl   $0x1,%ecx
        =E2=94=82       xorl   %edx,%edx

I also tried without "--damos_filter reject young" and "--damos_filter
allow young", but got the same single CPU ~100% utilization and
demotion poor performance.

Anton

=D1=87=D1=82, 1 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 16:27, SJ P=
ark <sj@kernel.org>:
>
> On Thu, 1 Oct 2026 15:08:38 +0300 Anton Gavriliuk <antosha20xx@gmail.com>=
 wrote:
>
> > With your support, my progress tremendously faster than I expected :-)
>
> Thank you.  The pleasure is mine :)
>
> >
> > Moving forward.
> >
> > In my VCF9.1-like example Demote/Promote bandwidth is limited by admin
> > up to 8GB/s.
> >
> > With CXL/PCIe 6.0 it may require moving pages between tiers 10's GB/s.
> > In this case, kdamond single CPU core limited or can use more CPU
> > cores if/when required ?
> >
> > ~1 year ago I played with AMD Zen5 9455 and 12 channels 6400 MT/s DDR5
> > DRAM, single thread core-to-local-memory bandwidth was ~49 GB/s.
>
> It is basically limited to single CPU core per kdamond.  You could split =
memory
> into multiple address ranges and assign kdamon per the range to utilize m=
ulti
> CPUs, if needed.  SK Hynix [1] was using such an approach.
>
> That said, I'm personally curious if such fast migration is really needed=
 in
> the real world workload.  I assume the real production workload would hav=
e
> stable access pattern but only occasionally get access pattern changes.
> Sometimes temporal and rapid access pattern change could also be made.  B=
ut for
> such temporal pattern change, doing migration would only be costy, since =
the
> data that suddenly hot could be soon be cold.  And reliability is importa=
nt in
> production.  Hence I was thinking slowly making the balance is better tha=
n too
> quickly and reactively making migrations that will turn out to be no real=
ly
> needed.
>
> That said, if you want to test faster migration speed, the multiple kdamo=
nds
> usage could be one way to test.  If it turns out it is really needed and
> splitting address ranges has problems, we can consider adding DAMOS featu=
re for
> utilizing multiple CPUs for faster migrations.
>
> [1] https://sched.co/2913n
>
>
> Thanks,
> SJ
>
> [...]
