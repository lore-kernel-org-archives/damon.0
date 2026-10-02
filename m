Received: from mail-ed2-f29.google.com (mail-ed2-f29.google.com [74.125.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDA429825
	for <damon@lists.linux.dev>; Fri,  2 Oct 2026 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935349; cv=pass; b=I3WCV4j0xgaVDgs1Ke4sCIxwaQI6nM34cSqyd0cPrdn8YaMtFc65BZik90ee4umknpKUSOAuZEU+IAVp6nAdpKEE/J/6f7QWiO2B8ZJMy3xdEgMcwT0NfJfPL+2qiJ0ayBGJ0D0LKGtVuGZbj7HfhyCx5Lryp+YY/9XbpeRb+zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935349; c=relaxed/simple;
	bh=rbThsON3CDICHhUCl9LCVvUqV8ka7hAMcCzczLw5h+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLHYp3b2221rOsfPq8M5oO9KpKYb4p8S0PZARsGQmwKD4+XzDGvdVcybAC1fqbhVkwNEvXrWAF6dHKhOhuAdoChVG7R6evrEw7ohbGJ6QZ8McDUEJnFba3M48Xl/rowDOgD51pu8JwAMPm2EUkaBSrINHcQr58ftzqOOhrgh4N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIZPrWWz; arc=pass smtp.client-ip=74.125.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIZPrWWz"
Received: by mail-ed2-f29.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso9209631a12.0
        for <damon@lists.linux.dev>; Fri, 02 Oct 2026 03:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790935346; cv=none;
        d=google.com; s=arc-20260327;
        b=qLhXpSEpfyfETQcxJyityX3Pt6fpDrceDZ9LzdyHF1n2JH6pzH781LGOaSki3JpG/2
         hWnqe2TGzE7dJSiaAkWp5uhSjj+jvvAUVk9QbH92U2T4+blud/uTrLIRrOdIt4CW3Bbk
         TKvAG3k608Nrhix32ZtI6zA5I+HZ0RDcQb4dsgt1/eOTNNuAxdINsGVRUsOzz2twKM18
         zgyXUvyq02obGMviHC2WiMWosBFmwaVgECcLwtjltspeg4k6QqFacPf6/HYigsgVR4Ag
         9jNOQOJUbeElKTumqotswb7BHsfn2u4KWqCIgg7OUrsLly0zhrIJsR5ps8TqprrzoJi2
         6t8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alCoBJB4NlH9OhBbA6zCWGf99zpX589m2NdzoouEwb8=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=fkVPQS60nUo7Q+RtA1otAhQlnGvYXnhY3o+2GHbVvADmwwaaMFPhGTncH+79AZEw5l
         QD7FMvlfqusXYNGdjL4R4y0TXmNnitPB5kAq1misni8KA+HI8wXrKsv6DEWrnfg6hlw0
         nMbmwfIs23IKliF7NYm+W1OSWZVSy72m7mzu9711F2DtbMsnWjXDcxh8oX5KZqPaLtCu
         219RhsceUhAtrNVduiFj444/PdzqC8wa9TjA5VgM/HEK87tRR6ZfxerelwwnQnDuvEEB
         l8NT/MaD71Dudr0GJlGBz5hJIc9G7jcMnSkx/qSxI4H1LUBPiBG7m+T78PMZ1/zskD+k
         NqKw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790935346; x=1791540146; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=alCoBJB4NlH9OhBbA6zCWGf99zpX589m2NdzoouEwb8=;
        b=GIZPrWWzis4rG5QNnz4aA2Zd3wW2laymR8SrVazEJEamv2Ts+3VBnqbunucJ7IijNh
         TMYg9d/DOp8kuqhxWjMbuWKX0ZMycVNcCKzi1kiKa+EPP2jIxesbUBl0sf97oJ6SYsKj
         zK7RUmOs8AbqS0sqbhTYDCRYRR9VgfhSJY1bdKd3iApKJ2P98jvyjdVmKi0p4ZpL3laA
         +RXrbtctZtKyxX8n5cpFSHcnAUJdAbu9kfuU931tMAoU93fdXXNCNTYRSXik8hJ4i73E
         0Jgvt62im51oXCwnDOnAREzZrofnnSfqIEPEeK5TUtKZR+ub/bEHS0w2pEwuTQPIkE/J
         dboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935346; x=1791540146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alCoBJB4NlH9OhBbA6zCWGf99zpX589m2NdzoouEwb8=;
        b=QPPCX31oHH+tdjIMnGBW1I7nh8IFJFN3tgCMrOaj2BhWbvfPD3AY1cgBXqwrfz+ZOk
         wq8X8gX/n4nkFD+tHncWZNln1SR6OsNldzCGu7AtreXH1k118+9JiCSpyy4WwzflcAzB
         0+GShZVsACZCO0Clp/quxhFneIwjGvLTXXkP8HJIkuVTBOgps80WNcDtDp+81rH+UOoc
         mxgtjvg4mA/ztMqqQQbUowcHSA4hkwQti0AHHECbl5Fx52CcRcfend638u5jvO0RZgz2
         KrDvoWAdEdbc51zy8nVuM7eAy0VgBj2aYDMw8mBRdEvUxeCoNHu8D3Q6beoxvEaWGQgv
         5tfg==
X-Gm-Message-State: AFq9FYKkfwF+tLGc8sgItlgvzuhBW7JNyFanDWHfJ8cjwJ6pZF6H7j03
	Bu6ETsZyREEY8OUyFL1Uanr5q/5hWFw/aJlSNhMBr3q7dA8hcDpwOMTA57iLubpaIrkR8UYnQ0m
	8wRJFKHncBDoqO8eGl7T3oKTr2JegrbI=
X-Gm-Gg: AYBFou3UJJLWvCgeC3Aw4DiCc/w6bYZvYPIvVDhEjobjzvtY+h29OPw7w5FMlfKhz5V
	B6/6E29j7CZzu088YJDcdoByJpDL/qHXEc1PELna8JO48ZEuWlXHoADudTIpco244SCpshLHf3u
	GfFrv/9Jh1aGZfWz5gqrzd/wWOSPX3N4Hmuk5+WmNODAgGbZBcdY5U9Xf+hwY4PEIagMr8iUk37
	JC3usf5Qr+lO0H2kTtZvzLdqkAyNnPUwgayvSLx2F8+9ju+3c9qVKksLtmNT+Yt/rjkiGDihO9v
	+TRIAtmJ9c2mv0yS58kOquoFumjJ/p2kXZbtkGp+ksrB1njXDVCpuii2
X-Received: by 2002:a05:6402:3253:b0:6ae:1a0a:ae9b with SMTP id
 4fb4d7f45d1cf-6af9e2ddbadmr1145081a12.25.1790935345151; Fri, 02 Oct 2026
 03:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjpweWDACdt3HKtup=8Byp00ePakcHJWEY=WdGT7MT6yxA@mail.gmail.com>
 <20261002083444.40553-1-sj@kernel.org>
In-Reply-To: <20261002083444.40553-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 2 Oct 2026 13:02:13 +0300
X-Gm-Features: AclHuK9BUSplSUKVRCd4wyfWfCF9mMrcVl-ook_5Qutj5kokcHbhPwFm94Vl_os
Message-ID: <CAAiJnjpBdRQnmsm8zB-Bh7taeBkOPadhQWOk6-a2dfTxYVMiZw@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peak sequential write to slower tier ~12 GB/s.
I set the upper limit 8 GB/s just to keep those PMEM modules not overloaded=
.

For Memory Tiering with OLTP-like workloads needs to be
promoted/demoted, 1.4 GB/s is OK.
But for bandwidth intensive workloads such as analytics, AI, VDI,...
1.4 GB/s is too slow.

On the server where I test Memory Tiering, Intel CPU 8280L installed.
Despite being already 7 years old, any single CPU core has 13-14 GB/s
bandwidth access to local memory.

So from my point of view - even if we increase the number of cores
keeping in mind 1.4 GB/s per core, we need so many cores to perform
10's GB/s demote/promote.  Firstly we need to improve demote/promote
bandwidth for single CPU core, from 1.4 GB/s to at least 9-10 GB/s.

> You could also confirm
> this by measuring the migration speed using move_pages() like system call=
,
> which also use the migration code.

I'm not a developer and I need to spend more time thinking about how
to do that, but I tried,

I used migratepages command, which is probably use migrate_pages()
instead of move_pages(), but I got the same poor bandwidth and stack
as with DAMON/DAMOS Memory Tiering,

top - 12:43:59 up 13 min,  2 users,  load average: 0.65, 0.88, 0.76
Tasks: 757 total, 2 running, 755 sleep, 0 d-sleep, 0 stopped, 0 zombie
%Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.=
0 st
MiB Mem : 6839822.+total, 6438483.+free, 416313.2 used,    669.8 buff/cache
MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6423508.+avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND
   2935 root      20   0    2644   1764   1644 R  99.7   0.0   0:42.19
migratepages
   2941 root      20   0   10884   6192   3916 R   0.7   0.0   0:00.04 top
   1238 systemd+  20   0   15860   6996   5952 S   0.3   0.0   0:00.37
systemd-oomd
   1928 root      20   0  666268  24448  23440 S   0.3   0.0   0:00.34 rsys=
logd
      1 root      20   0   25840  15532  10492 S   0.0   0.0   0:02.15 syst=
emd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthr=
eadd
      3 root      20   0       0      0      0 S   0.0   0.0   0:00.00
pool_workqueue_release
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
kworker/R-rcu_gp


|---------------------------------------||---------------------------------=
------|
|--            System DRAM Read Throughput(MB/s):        759.41
        --|
|--           System DRAM Write Throughput(MB/s):        751.36
        --|
|--             System PMM Read Throughput(MB/s):        701.24
        --|
|--            System PMM Write Throughput(MB/s):       1402.15
        --|
|--                 System Read Throughput(MB/s):       1460.65
        --|
|--                System Write Throughput(MB/s):       2153.50
        --|
|--               System Memory Throughput(MB/s):       3614.15
        --|
|---------------------------------------||---------------------------------=
------|


Samples: 92K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
48280162400 lost: 0/0 drop:
Overhead  Shared Object                      Symbol
  49.82%  [kernel]                           [k] migrate_folio_unmap
  16.52%  [kernel]                           [k] clear_highpages_kasan_tagg=
ed
  13.56%  [kernel]                           [k] copy_mc_fragile
   1.80%  [kernel]                           [k] smp_call_function_many_con=
d
   1.06%  [kernel]                           [k] page_vma_mapped_walk
   0.95%  [kernel]                           [k] try_to_migrate_one
   0.94%  [kernel]                           [k] folio_migrate_flags
   0.71%  [kernel]                           [k] rmqueue_bulk
   0.61%  [kernel]                           [k] remove_migration_pte
   0.54%  [kernel]                           [k] __free_one_page
   0.50%  [kernel]                           [k] migrate_folio_move
   0.48%  [kernel]                           [k] folio_batch_move_lru
   0.47%  [kernel]                           [k]
__list_del_entry_valid_or_report


Samples: 37K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
33608407521
migrate_folio_unmap  /proc/kcore [Percent: local period]
Percent =E2=94=82       movq   %r13,0x20(%rsp)
   0.02 =E2=94=82       movq   %rdx,%r13
        =E2=94=82       movq   %r14,0x28(%rsp)
        =E2=94=82       movl   %r9d,%r14d
        =E2=94=82       movq   %r15,0x30(%rsp)
   0.01 =E2=94=82       movq   %r8,%r15
        =E2=94=82     =E2=86=92 callq  *%rax
   0.04 =E2=94=82       testq  %rax,%rax
        =E2=94=82     =E2=86=93 je     2e3
   0.01 =E2=94=82       movq   %rbp,0x10(%rsp)
        =E2=94=82       movq   %rax,%rbp
   0.03 =E2=94=82       movq   %rax,(%r15)
        =E2=94=82       movq   $0x0,0x28(%rax)
  99.52 =E2=94=82       lock
        =E2=94=82       btsq   $0x0,(%rbx)
   0.01 =E2=94=82     =E2=86=93 jb     26b
   0.13 =E2=94=82 67:   movq   (%rbx),%rdx
   0.01 =E2=94=82       testq  $0x2,(%rbx)
   0.01 =E2=94=82     =E2=86=93 je     e2
        =E2=94=82       cmpl   $0x2,%r14d
        =E2=94=82     =E2=86=93 je     d2
        =E2=94=82       movq   0x40(%rsp),%r8
        =E2=94=82       movq   %rbx,%rdi
        =E2=94=82       movl   $0x1,%ecx
        =E2=94=82       xorl   %edx,%edx

Lastly I used migratepages between two fast tiers (numa nodes 0 & 1)
and got 1.5 GB/s.
All this is too slow for the coming CXL era.

Anyway, I'm ready to proceed in assisting you in checking/testing if
you are also interested.

Anton

=D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 11:34, SJ P=
ark <sj@kernel.org>:
>
> On Thu, 1 Oct 2026 19:54:09 +0300 Anton Gavriliuk <antosha20xx@gmail.com>=
 wrote:
>
> > > That said, I'm personally curious if such fast migration is really ne=
eded in
> > > the real world workload.  I assume the real production workload would=
 have
> > > stable access pattern but only occasionally get access pattern change=
s.
> > > Sometimes temporal and rapid access pattern change could also be made=
.  But for
> > > such temporal pattern change, doing migration would only be costy, si=
nce the
> > > data that suddenly hot could be soon be cold.  And reliability is imp=
ortant in
> > > production.  Hence I was thinking slowly making the balance is better=
 than too
> > > quickly and reactively making migrations that will turn out to be no =
really
> > > needed.
> >
> > > That said, if you want to test faster migration speed, the multiple k=
damonds
> > > usage could be one way to test.  If it turns out it is really needed =
and
> > > splitting address ranges has problems, we can consider adding DAMOS f=
eature for
> > > utilizing multiple CPUs for faster migrations.
> >
> >
> > I agree with you!, but now it looks that demotion is too slow.
> > The server is completely idle, only I play with memory tiering.
> >
> > As CPU-less NUMA nodes I use Intel Optane PMEM configured as DAX device=
s,
> >
> > [root@localhost anton]# ndctl list
> > [
> >   {
> >     "dev":"namespace1.0",
> >     "mode":"devdax",
> >     "map":"dev",
> >     "size":3183575302144,
> >     "uuid":"865e9ee4-6334-4094-ac56-8b452bf4f53f",
> >     "chardev":"dax1.0",
> >     "align":2097152
> >   },
> >   {
> >     "dev":"namespace0.0",
> >     "mode":"devdax",
> >     "map":"dev",
> >     "size":3183575302144,
> >     "uuid":"ce77e90e-31bd-4057-8076-1f5d4374e9a2",
> >     "chardev":"dax0.0",
> >     "align":2097152
> >   }
> > ]
> > [root@localhost anton]#
> >
> > and then configured as system ram by next command,
> >
> > daxctl reconfigure-device --mode=3Dsystem-ram all
> >
> > The problem is during demotion (to keep 25% free in the fast tier),
> > kdamond.0 utilizes single CPU core ~100%, but writing to the slower
> > tier (System PMM Write) ~1.4 GB/s what is much slower than defined
> > limit 8 GB/s.
>
> The defined limit is only upper limit, so real speed could be slower than=
 that.
> FWIW, the example memory tiering script [1] uses 200 MiB/second as the
> upperlimit.  It was set by my gut feeling, not by some good data, though.
>
> I personally feel like ~1.4 GB/s is still a good speed for long-running
> production workloads, though I don't have a data to support that.  Do you=
 have
> some data or reason to pursue 8 GB/s ?
>
> >
> >
> > top - 16:26:06 up 12 min,  2 users,  load average: 0.81, 0.75, 0.54
> > Tasks: 765 total, 2 running, 763 sleep, 0 d-sleep, 0 stopped, 0 zombie
> > %Cpu(s):  0.0 us,  1.8 sy,  0.0 ni, 98.2 id,  0.0 wa,  0.0 hi,  0.0 si,=
  0.0 st
> > MiB Mem : 6839822.+total, 6439081.+free, 415816.0 used,    465.2 buff/c=
ache
> > MiB Swap:   8192.0 total,   8192.0 free,      0.0 used. 6424006.+avail =
Mem
> >
> >     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ =
COMMAND
> >    3227 root      20   0       0      0      0 R  99.8   0.0   1:28.92 =
kdamond.0
> >    2771 root      20   0 6932852  10260   5608 S   0.7   0.0   0:02.95
> > pcm-memory
> >    1593 root      20   0   17088   8352   7140 S   0.3   0.0   0:00.99
> > systemd-logind
> >    2263 root      20   0  300.4g 294.4g   6108 S   0.3   4.4   4:42.72
> > valkey-server
> >    3327 root      20   0   10916   6064   3764 R   0.3   0.0   0:00.16 =
top
> >       1 root      20   0   25356  15232  10456 S   0.0   0.0   0:02.13 =
systemd
> >       2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 =
kthreadd
> >
> >
> >
> > |---------------------------------------||-----------------------------=
----------|
> > |--            System DRAM Read Throughput(MB/s):        751.95
> >         --|
> > |--           System DRAM Write Throughput(MB/s):        742.58
> >         --|
> > |--             System PMM Read Throughput(MB/s):        693.12
> >         --|
> > |--            System PMM Write Throughput(MB/s):       1387.47
> >         --|
> > |--                 System Read Throughput(MB/s):       1445.08
> >         --|
> > |--                System Write Throughput(MB/s):       2130.05
> >         --|
> > |--               System Memory Throughput(MB/s):       3575.12
> >         --|
> > |---------------------------------------||-----------------------------=
----------|
> >
> >
> >
> > Samples: 111K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> > 51312892466 lost: 0/0 drop
> > Overhead  Shared Object                      Symbol
> >   47.50%  [kernel]                           [k] migrate_folio_unmap
> >   16.11%  [kernel]                           [k] clear_highpages_kasan_=
tagged
> >   14.93%  [kernel]                           [k] copy_mc_fragile
> >    1.63%  [kernel]                           [k] smp_call_function_many=
_cond
> >    1.44%  [kernel]                           [k] page_vma_mapped_walk
> >    0.97%  [kernel]                           [k] folio_migrate_flags
> >    0.87%  [kernel]                           [k] try_to_migrate_one
> >    0.66%  [kernel]                           [k] rmqueue_bulk
> >    0.61%  [kernel]                           [k]
> > __list_del_entry_valid_or_report
> >    0.59%  [kernel]                           [k] remove_migration_pte
> >    0.50%  [kernel]                           [k] rmap_walk_anon
> >    0.45%  [kernel]                           [k] __free_one_page
> >    0.44%  [kernel]                           [k] migrate_folio_move
> >    0.44%  [kernel]                           [k] folio_add_anon_rmap_pt=
es
> >    0.40%  [kernel]                           [k] lru_gen_add_folio
> >    0.40%  [kernel]                           [k] __mod_memcg_lruvec_sta=
te
> >    0.39%  [kernel]                           [k] mod_node_page_state
> >    0.35%  [kernel]                           [k] migrate_pages_batch
> >    0.33%  [kernel]                           [k] _raw_spin_lock
> >    0.33%  [kernel]                           [k] up_read
> >
> >
> >
> > Samples: 222K of event 'cpu/cycles/P', 4000 Hz, Event count (approx.):
> > 64449579226
> > migrate_folio_unmap  /proc/kcore [Percent: local period]
> > Percent =E2=94=82       movq   %r13,0x20(%rsp)
> >    0.01 =E2=94=82       movq   %rdx,%r13
> >         =E2=94=82       movq   %r14,0x28(%rsp)
> >         =E2=94=82       movl   %r9d,%r14d
> >    0.00 =E2=94=82       movq   %r15,0x30(%rsp)
> >    0.01 =E2=94=82       movq   %r8,%r15
> >         =E2=94=82     =E2=86=92 callq  *%rax
> >    0.16 =E2=94=82       testq  %rax,%rax
> >         =E2=94=82     =E2=86=93 je     2e3
> >    0.01 =E2=94=82       movq   %rbp,0x10(%rsp)
> >    0.01 =E2=94=82       movq   %rax,%rbp
> >    0.04 =E2=94=82       movq   %rax,(%r15)
> >    0.00 =E2=94=82       movq   $0x0,0x28(%rax)
> >   99.27 =E2=94=82       lock
> >         =E2=94=82       btsq   $0x0,(%rbx)
> >    0.01 =E2=94=82     =E2=86=93 jb     26b
> >    0.11 =E2=94=82 67:   movq   (%rbx),%rdx
> >    0.01 =E2=94=82       testq  $0x2,(%rbx)
> >    0.01 =E2=94=82     =E2=86=93 je     e2
> >         =E2=94=82       cmpl   $0x2,%r14d
> >         =E2=94=82     =E2=86=93 je     d2
> >         =E2=94=82       movq   0x40(%rsp),%r8
> >         =E2=94=82       movq   %rbx,%rdi
> >         =E2=94=82       movl   $0x1,%ecx
> >         =E2=94=82       xorl   %edx,%edx
> >
> > I also tried without "--damos_filter reject young" and "--damos_filter
> > allow young", but got the same single CPU ~100% utilization and
> > demotion poor performance.
>
> Thank you for doing these great profiling and sharing the results, Anton.
> Apparently the bottleneck is not in DAMON specific code including the fil=
tering
> part.  Instead, the bottleneck is in the migration code, which is out of =
DAMON,
> according to my understanding of the profiling result.  You could also co=
nfirm
> this by measuring the migration speed using move_pages() like system call=
,
> which also use the migration code.
>
> You may need to optimize the migration code, or make DAMON uses multiple =
CPUs
> if faster speed is really what needed.  I'd suggest using the address ran=
ge
> split approach that I suggested in the previous reply.  If it becomes cle=
ar the
> faster migration is really needed, we could start thinking about making D=
AMOS
> use multiple CPUs without the address range split.
>
> [1] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh
>
>
> Thanks,
> SJ
>
> [...]
