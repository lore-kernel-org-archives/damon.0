Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088B4F30E4
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614980; cv=pass; b=j1HUJ9aLhU2x80yLgHTqmbwKfL0xA/T1YGloESSd5OA1/y4WA/SwWFD636ui6LKgj7zxVJtLHQOWr46QjmQWtONUu9uYN9g8bA51NbmkMQ5tfxYZo77TkioCYd+BhzeL+ouaOkK06lCP8nZiJ+fRz4dUdL4CL8U3cnu3vGWCQpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614980; c=relaxed/simple;
	bh=bD8SrmtfHJxopvcbF6GqCeMttD85fVcVhseSQjuOp0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXsrc7cQOsxnSUyOweioOabF0yatM+dvz2GarBrHS8kQWnyhuulpTMWZL7jh2KtlH/DWSJZfQBxYALiHHt0IsfYoLurZgcV5IwGTSHo5tB+5KKauCg4raLadWgLw9EvVtDxWAsdNzfj5lCM4nd4mcAs37GMBhZ8r70fnuESSboc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXRezosB; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXRezosB"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a996c8adf3so5289030a12.1
        for <damon@lists.linux.dev>; Mon, 28 Sep 2026 10:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790614976; cv=none;
        d=google.com; s=arc-20260327;
        b=ffPOkIzOHPZXpLbg6NoV5oiHPOKtiFhDd+o3dmGU1RmxkiE6M2U505jQCRskaiwyL1
         zmx415uyOBa4Wx3zsIJflSSyvDs8w6/0xZzjn5T/loksRRWFu9jbcrz2J4eCzK/2J/xG
         3FhH5hr6h+jbrSQyDL8Pbk3148zYtO1BthiLyNIkP/Z0nqyXeav2ZQH30iJX8q0/8I4e
         ZLb+DjdtfXolDM/kNYzi5mx/qlEcwAyJhcXSPA7zRpXsou4SVolDriiKXkDjAzB9qUV5
         7VSBngQL2x509dYP9t5iBRddg5yo2GB3VKAr8s/d5JshgfDI3c46aHtaFoymliBdk7zc
         cJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WDS/6F7ePfG8NCROLueneqB+eYwJ7jmwAQaY+EoG87M=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=r5QuvCU6da88K3Td6eR0/w4wbshtZYtr9h0OdSyNK7U20A7moZ/XYMP3A4pitXL2B9
         knUWbM2bKfZ9WUKuNSSdRIOE1TgFBn+f2lWxM/k5j9OGeTXxK4vUFTe4e7b3L5DalXiu
         /zGtBcLBXi+Wgv9UIEikViUDPwaTg15rFJTPbz0BEZB5CaClWTlm8hneK/Q1VeqQc5JZ
         8p+SvD1V+A4U+WHeCY7xm78CE/TfB+/tXpADmTRCreLDgyvVjN2uwIMgjr9YKX0bGWem
         zMk4+xYRPUsEd8/FYPS/hhi49VcL09EI72xMKaMH2S6dnf30S3A443i+BRgyT10EtiRR
         2sRg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790614976; x=1791219776; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WDS/6F7ePfG8NCROLueneqB+eYwJ7jmwAQaY+EoG87M=;
        b=JXRezosBCufzcC2KcIo1sV5SVilSuCPnuvRP3bdGgfiGVgyFIMKWR/bFBZb7ZnEH8Z
         Ze5WlOHzLSzddk35n5dSlZE2doKx+v8IX7kbo6/VY8Ia7a59joTHfCYRmV70wti38vwa
         GHvGjU2lf79LYEmgsGkJVdyrV+t119r/9mwCRQUnAVNxx4Gg4vhBVyj3PcfCdEmJJxkV
         ykW+R8gt+HBalq2gJnGSv/20LQLvnZxhEv3TQr2p9Hjt00Mks6ZSk/El/YRM0ADfoaQi
         bM10dXMD+S8T3eUqWCLj15yJqSWxre2F4TkKd7vfcRb1l4cey0fbfby/6/70WRdlF9sx
         glyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614976; x=1791219776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDS/6F7ePfG8NCROLueneqB+eYwJ7jmwAQaY+EoG87M=;
        b=KK8sjclIWUAv3yKvwQCem7eKkKjFlF1oyrnzRCBFr/ERgxPU0kwD8c2WDLQqTW066o
         5XEhGF1P5Ai/GejqHjGhlB2yMp8yDWYjPqiRn+/f3n1jJCaZQIHrtnWxHE16Jq8mlCYo
         ktznG/ti3+f8+e4k14zX+sC/hp1ng4UMxp11g37DXtwk4oP+fM0BdDE+jB9+Sr9bJurJ
         JdDc8BhOh71o1XNvTahKydW7aL1cGoE2ZP+kWCuZ54Ve/mU1muhr2R/FoKfjgAxHONnW
         wgpRn7rxMAPnsVB7KWQHin+GtVu9dNdNqGnlj+/+oCBKcIRtMcohEeLvH+lFOyz/B7Pf
         NZ5A==
X-Gm-Message-State: AFq9FYKWAsG8L3ZkyRCnH3YWa0zsYT8GEuiAQLSNGSNaQPglnu2YQsIV
	4TRLdyorbMsj5E/yBfaKpzBXTKbyQ4D6dz2/dDkfIJj0LWqFmqeLZHmC6WTFJXIwZeYXtQc9L0U
	NRO8lyH2719kGDSM4Vt/TDOlj9uUruIgtoYrF
X-Gm-Gg: AYBFou1KvoFpy1WFtqlCdPkSegJ6vcbEc4iEZvksvAQMOKDqgRQ0t+uIDhmSHJmXP4j
	WafFmueTJsY7Dvo7Bca6J37SgoBHC9CWISgF3deLJH0qteHnb2s3xSpsD8dTtYbBiL9Gyx2ea3l
	NpCHudn+CAM9zSLkGl9c6oIOVSqJDoJ/23nlQ/pV775IGdHj41hYXw3IPoCgLrAqe50Zu2ET7tp
	XbiE3EiY4QkBVYF4gWzvDaAK50nrHO8UJ8KWPmnV7dRLBtTzYX3OXTykMYQKa1p5R1SMqlvIE2E
	rnx/VwNdtu5rnUwDJeNXEAj0i1v97XscVH7O+uInBZqESsrEJtQlvjH4
X-Received: by 2002:a05:6402:5019:b0:6aa:734a:a084 with SMTP id
 4fb4d7f45d1cf-6aac8f72918mr11039086a12.27.1790614976105; Mon, 28 Sep 2026
 10:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjp5F8ZuPG1gEsD_Wgs7Z+GToz67nzjr0490sz9y328=dg@mail.gmail.com>
 <20260928081546.39695-1-sj@kernel.org>
In-Reply-To: <20260928081546.39695-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Mon, 28 Sep 2026 20:02:43 +0300
X-Gm-Features: AclHuK9Nv1YJ07G2J2t7N1TvUKx12jR_zbNMyqRU4Jbwca2YcZTyA3z95u9AXNI
Message-ID: <CAAiJnjrJxoKy3AdXHiCSEGZyDwSqDJa4riO5FZeQX9uZKfjgmg@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thank you for sharing your use case and question!

Thank you for your quick response and your answer/comments.

We already had memory tiering implemented at hardware level 5-7 years
ago with Intel's Optane PEM when configured in Memory Mode.
Now we do the same thing at Linux level :-)
I'm new at DAMON/DAMOS, there are lots of new tunables to me.

> The example memory tiering script [1] uses 4% as intervals goal.  Is ther=
e a
> reason to use 97% as the goal instead?

Oohhh... I moved to 5%.

> Is the above node_mum_used_bp what you really want?  That means you want =
to
> promote hot pages from node 2 to node 0, until the node 0 memory utilizat=
ion
> becomes 99.7%.  That overlaps with the demotion goal (50% free memory of =
node
> 0) quite a lot.  I'd suggest smaller overlap, say, 50.3%, to keep healthy
> circulation of hot/cold pages while not consuming too much resource under
> stabilized access pattern.

> DAMOS quota auto-tuning supports two tuner algorithms [2], consistent and
> temporal.  As the documentation [2] explains, 'consistent' tuner assumes =
it
> should keep applying the action in a level to keep the goal achieved.  In=
 this
> case, for example, the demotion scheme assumes there will be continued
> promotion and therefore it keeps demoting.  If there is no appropriate
> promotion, it could result in demoting more than expected amount.

So let me firstly understand what I really want to test :-)

Anton

=D0=BF=D0=BD, 28 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 11:1=
5, SJ Park <sj@kernel.org>:
>
> Hello Anton,
>
> On Sun, 27 Sep 2026 20:26:21 +0300 Anton Gavriliuk <antosha20xx@gmail.com=
> wrote:
>
> > Hello
> >
> > I would like to play with memory tiering with DAMON/DAMOS auto-tuning
> > (between numa nodes 0 & 2) based on valkey and memtier_benchmark.
>
> Thank you for sharing your use case and question!
>
> > The goal - keep numa node 0 50% free and promote cold pages from numa
> > node 2 to numa node 0 immediately when they become hot.
> > This is Fedora Server 44 up-to-date with the 7.2.8 kernel.
> >
> > [root@localhost ~]# numactl -H
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
> > 22 23 24 25 26 27
> > node 0 size: 386590 MB
> > node 0 free: 337165 MB
> > node 1 cpus: 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
> > 47 48 49 50 51 52 53 54 55
> > node 1 size: 387055 MB
> > node 1 free: 338204 MB
> > node 2 cpus:
> > node 2 size: 3033088 MB
> > node 2 free: 3032998 MB
> > node 3 cpus:
> > node 3 size: 3033088 MB
> > node 3 free: 3032998 MB
> > node distances:
> > node     0    1    2    3
> >    0:   10   20   25   35
> >    1:   20   10   35   25
> >    2:   25   35   10   20
> >    3:   35   25   20   10
> > [root@localhost ~]#
> > [root@localhost ~]# /home/anton/Linux/mlc
> > Intel(R) Memory Latency Checker - v3.13
> > Measuring idle latencies for sequential access (in ns)...
> >                 Numa node
> > Numa node            0       1       2       3
> >        0          82.3   147.6   173.8   238.0
> >        1         146.7    82.0   238.7   172.2
> >
> >
> > The Goal:
> >
> > 1. There are two tiers, fast tier - numa node 0; slow tier - numa node =
2
> > 2. Keep fast tier 50% free
> > 3. Demote valkey inactive >=3D5 min pages from fast to slow tier
> > 4. Promote valkey hot pages from slow tier to fast tier immediately
> > when accessed
> > 5. Demote and Promote bandwidth performance limit up to 8 GB/s; CPU
> > performance unlimited
> > 6. Monitoring intervals for Demote/Promote 500ms
> >
> > What I already done -
> >
> > Launch Valkey Pinned to Node 0 DRAM
> >
> > numactl --cpunodebind=3D0 --preferred=3D0 valkey-server \
> >   --port 6379 \
> >   --protected-mode no \
> >   --save "" \
> >   --appendonly no \
> >   --maxmemory 300gb \
> >   --maxmemory-policy noeviction &
> >
> >
> > Command to Load ~200+ GB
> >
> > memtier_benchmark \
> >   -s 127.0.0.1 -p 6379 \
> >   -t 16 -c 16 \
> >   -d 10240 \
> >   --ratio=3D1:0 \
> >   --key-pattern=3DP:P \
> >   --distinct-client-seed \
> >   --key-maximum=3D20000000 \
> >   --pipeline=3D32 \
> >   -n allkeys
> >
> >
> > [root@localhost anton]# numastat -p $(pgrep valkey-server)
> >
> > Per-node process memory usage (in MBs) for PID 5631 (valkey-server)
> >                            Node 0          Node 1          Node 2
> >                   --------------- --------------- ---------------
> > Huge                         0.00            0.00            0.00
> > Heap                         0.11            0.00            0.00
> > Stack                        0.03            0.00            0.00
> > Private                 238356.61            0.46            4.82
> > ----------------  --------------- --------------- ---------------
> > Total                   238356.75            0.46            4.82
> >
> >                            Node 3           Total
> >                   --------------- ---------------
> > Huge                         0.00            0.00
> > Heap                         0.00            0.11
> > Stack                        0.00            0.03
> > Private                      0.00       238361.90
> > ----------------  --------------- ---------------
> > Total                        0.00       238362.04
> >
> >
> > damo start \--numa_node 0 --monitoring_intervals_goal 97% 3 5ms 10s
>
> The example memory tiering script [1] uses 4% as intervals goal.  Is ther=
e a
> reason to use 97% as the goal instead?
>
> > \--damos_action migrate_cold 2 --damos_access_rate 0% 0%
> > \--damos_apply_interval 1s \--damos_quota_interval 1s
> > --damos_quota_space 8GB \--damos_quota_goal node_mem_free_bp 50% 0
> > \--damos_filter reject young \
>
> You mentioned you want to demote >=3D5 minutes inactive pages.  But, the =
above
> command doesn't have '--damos_age' option.  It means DAMON will demote no=
de 0
> pages as soon as it finds it was not accessed, even if it was not accesse=
d for
> <5 minutes.  You could let DAMON know you want to demote only >=3D5 minut=
es
> inactive pages by adding '--damos_age 5m max' option.
>
> > --numa_node 2
> > --monitoring_intervals_goal 97% 3 5ms 10s \--damos_action migrate_hot
>
> Again, I'm curious why you use 97% goal.
>
> > 0 --damos_access_rate 5% max \--damos_apply_interval 1s
> > \--damos_quota_interval 1s --damos_quota_space 8GB \--damos_quota_goal
> > node_mem_used_bp 99.7% 0 \--damos_filter allow young
>
> Is the above node_mum_used_bp what you really want?  That means you want =
to
> promote hot pages from node 2 to node 0, until the node 0 memory utilizat=
ion
> becomes 99.7%.  That overlaps with the demotion goal (50% free memory of =
node
> 0) quite a lot.  I'd suggest smaller overlap, say, 50.3%, to keep healthy
> circulation of hot/cold pages while not consuming too much resource under
> stabilized access pattern.
>
> > \--damos_nr_quota_goals 1 1 --damos_nr_filters 1 1 \--nr_targets 1 1
> > --nr_schemes 1 1 --nr_ctxs 1 1
> >
> > And it is demoted much more, almost all pages than the goal of 50%
> > free numa node 0.
> >
> > [root@localhost anton]# numastat -p $(pgrep valkey-server)
> >
> > Per-node process memory usage (in MBs) for PID 5631 (valkey-server)
> >                            Node 0          Node 1          Node 2
> >                   --------------- --------------- ---------------
> > Huge                         0.00            0.00            0.00
> > Heap                         0.02            0.00            0.09
> > Stack                        0.02            0.00            0.01
> > Private                  24389.88            0.46       213971.55
> > ----------------  --------------- --------------- ---------------
> > Total                    24389.92            0.46       213971.65
> >
> >                            Node 3           Total
> >                   --------------- ---------------
> > Huge                         0.00            0.00
> > Heap                         0.00            0.11
> > Stack                        0.00            0.03
> > Private                      0.00       238361.90
> > ----------------  --------------- ---------------
> > Total                        0.00       238362.04
> >
> > I just want that demotion process to stop when there is 50% free at num=
a node 0.
> >
> > Where am I wrong, how to fix that ?
>
> DAMOS quota auto-tuning supports two tuner algorithms [2], consistent and
> temporal.  As the documentation [2] explains, 'consistent' tuner assumes =
it
> should keep applying the action in a level to keep the goal achieved.  In=
 this
> case, for example, the demotion scheme assumes there will be continued
> promotion and therefore it keeps demoting.  If there is no appropriate
> promotion, it could result in demoting more than expected amount.
>
> To me, this seems like the workload has no much hot data, so demotion is =
much
> more stronger.
>
> For path forward, I'd suggest trying 'temporal' tuner [2].  It is designe=
d to
> immediately stop after achieving the goal.
>
> If it still doesn't work, I'd suggest tracing damon:damos_esz tracepoint =
with
> the numastat output.  It will show if the autotune is working as expected=
.
>
> For long term production use case, I'd like to suggest running the exampl=
e
> tiering config [1] and see if it also gives you unexpected results.
>
> [1] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh
> [2] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#aim-or=
iented-feedback-driven-auto-tuning
>
>
> Thanks,
> SJ
>
> [...]
