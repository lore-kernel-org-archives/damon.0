Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1541D657
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529997; cv=pass; b=IO9TY0KS4QRZS6NKo4uLfnNNuF5ObULJTynSY1TXgc59swfV8PiFT/EQrz6xX3/MbQTuptdFnWhirxeUvLFmpDeKuW4wwIMdOTngddjtFJnOa2iQlRBoSOy9xIrAxYGMILa7G0Ql8c++4PuydBJHJaGUxwLWJn81+l58khKvp3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529997; c=relaxed/simple;
	bh=B7Z3QAP0SrUljYjWx5QVlEjPHBPfjUenAInknvmoWiw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OoQVI6VH0WBNu54WZdZOXEZTWjVYqLQa5X/Ulk4FAGkAJbeIB1ff8jJdBCLEwJ/P2W4ZrR2cvVvPRVAoDp/Jrh05K0eIcFEU5FRtH09DDNpfq8cSWh77m8L/PkSVuQR4B+ff3ByoI+j1jGRvc320qrarQrHkZXK84L/Tmmx3R3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1I9pws3; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1I9pws3"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaeeacce15so3075122a12.1
        for <damon@lists.linux.dev>; Sun, 27 Sep 2026 10:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790529994; cv=none;
        d=google.com; s=arc-20260327;
        b=K+CffKOcaAW8Gg8+78+LOh74JKoepn8KZEgZSnpNjuvTGVQNuUh+Uy6oehtsrT+Xel
         blDeew9y0RC9tJAheRVIJAl/UAuRgjCe+d76ZHWihD2Bl2L2h6CvUlBhoyjVH+zO0Vaz
         pDJYls/4yRtHYmB8sZ73eiLTd07SxpqlHGM7qrxy69N0uqq2yq5voJjqv5XC0f+7MmDa
         0xvt0q6uUSQdr+CBtclyZ9pkwgE7rVMxZTp8mqxdciHZQ1yqv8qHVJ/OgKU6GJvTzl70
         Ee70IENQdjYBV03wcqfIUpn7IMK0K+Ktp+U2mbGOC/eNyFDwDyXvk9w1XnHHs0lkzCZ5
         iEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=s+GAuPAHz7vZKv/Y6cSrCMWQPagfyJO/rxJTGFqqn38=;
        fh=uPYgHvyHc4KATx191O2E05ZNTVt4T4xK9PRAqa70tys=;
        b=d8N10DVk+ghN/DuqoKVWuH9pAA3CTr21hGaFpSmG3K+CWYO6t121R4TwG/HDy7WfJm
         KexDIQK/mwpGTEJ9Oq0qa8tMT3tFVCGGLa+wHHYRZrrjUiICtk4RF2mj0IN1/OskbodY
         DJKqu2qPynhpMHQSlVyqx49fr1Jn40hKwxxa7C9CuYtjRK7xEUGsZzmOc6H66PE5wYK2
         7y0aZJ6JL6pNEN8jo37eEi3HjOeEUT/W4jKPV/+DKZ4V+Ttz279MJyavyh2j5z+XLzOB
         Ci0Ujq/qSbgemUz7NQjcuEZS5Xb1WQDpFOdnIZ714MypsE4nFEfx/1kFw5ld6FXSxXJW
         5+zg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790529994; x=1791134794; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s+GAuPAHz7vZKv/Y6cSrCMWQPagfyJO/rxJTGFqqn38=;
        b=i1I9pws3RGAPZWo+0wnQio9cPvY4vU9Dj+FMv6WEYUNGa26aAkou33pjJnMBstPuqE
         OKZSF1Ppmn4XU9t8oU09RAj5Xu0pFxsOIhYPQV+9Wu1AqMg+jq763IP/5Xyfbw58Ddtf
         BKhsJx+N2An9JGJbitPCwdL3/yUCbNmhFpWu+eaoOmCKRQfuKk9EjJFc/RX353lpbYE3
         1LhSR00jHAdohMu2WZq6yTBLxJ1UpW0cdgulGEoz8UzlhiDx0ViNYWc4FbbgVMvLv0oB
         AoQsnmpnnpcvTn2JBTtSIkiNSaO56FoI0mr3h38xlfl52oAfKMnUtmlKjXQ2PNIy/b/i
         ZMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790529994; x=1791134794;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+GAuPAHz7vZKv/Y6cSrCMWQPagfyJO/rxJTGFqqn38=;
        b=hvcyhY+jgfmPRfot9fcXaLs8qf6DMLSB8/tC6/wjtJqbIb/6+7dBbggxGkdnfZ85MB
         Q1vFFRAxFcMf/gxN0o4i0a8XDk5XXozlM/OQPBwsbILfnVlqtOz3Wnt//qrWc61l2YVM
         Vazdtf4o6krsIvc4Yx2PXTH+I/vkJRUf8fB5SQGsOpoGcCZK7RNXEqIXnTkVybpTSg6p
         PviBHb0YRIpWM9O0FZHKZ1Fj80Q6LCDpauWIMnuBCCqZc0cwddMsrr1Ozy5Axu8eFX6w
         MBaZZdWJxbifnBDw4fgBNh4rgcwRTULLCcDrgREbcMlzhOtgEn3PIJSVPyShJ0kRpcwn
         C/Ug==
X-Forwarded-Encrypted: i=1; AKwUvBwgZvBxvZjr6ueFtP5gbrwYnzHZ5o30B7LmLWeGZgiqdtk2GyOx9AXQGO871mBkfrsLMvxPAw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL9VqPyNGyP6Hl7uQZV4M1UQELN+9qxZai5aHAl9W4v8CvGf/Ku
	5a2lTAZcPySbxOu0KTTx+/h0ANcdKFW9sQ+iIk428UL2wH4f84IgiOApjgvRXnBRJqxBm0koBJw
	ptOTiGVHQ1KVsNDeaVTMSHUSmgVAHga0=
X-Gm-Gg: AYBFou2ZTjBq2UkSqnY4O2brcFWNHNaJntXhdZm2dD5T1ftn8p/k1vjIfEC1rAK9dOL
	D6KvXMqXi7eITptRkqyhecqDDG077nGriHi9wHFgHdOAEHzTPFIEUd8fjkLTi+1YCIa7svAJeih
	lXoshgbEich4GD9ryKThlYnfWMRFCgCzTOswjJzoJjZOu5WNYKpJtAiYj+QEG1LghvzmdIKi4Ap
	7ADLSJs6Vi99b4mnSvMCvCVeNOp0K9dqCJpQZ4c11CivuiuxPgWLFsG3IYodbEA39ncUYqGqyGv
	bzlmt+8PjQ+1lIJz1Mc+38jTMBd+TWbeS0XvZotox33ytCi8AyENteQ+DtIl1iHxlls=
X-Received: by 2002:a05:6402:4390:b0:6a5:fbc6:cad1 with SMTP id
 4fb4d7f45d1cf-6aac8f22fcemr7968545a12.7.1790529993391; Sun, 27 Sep 2026
 10:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Sun, 27 Sep 2026 20:26:21 +0300
X-Gm-Features: AclHuK-45jV61VRY-im1f159C9Y441qzNA1pGTdfudGOs65731jt40xHoJKPStg
Message-ID: <CAAiJnjp5F8ZuPG1gEsD_Wgs7Z+GToz67nzjr0490sz9y328=dg@mail.gmail.com>
Subject: Memory tiering with DAMON/DAMOS auto-tuning
To: sj@kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello

I would like to play with memory tiering with DAMON/DAMOS auto-tuning
(between numa nodes 0 & 2) based on valkey and memtier_benchmark.
The goal - keep numa node 0 50% free and promote cold pages from numa
node 2 to numa node 0 immediately when they become hot.
This is Fedora Server 44 up-to-date with the 7.2.8 kernel.

[root@localhost ~]# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
22 23 24 25 26 27
node 0 size: 386590 MB
node 0 free: 337165 MB
node 1 cpus: 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
47 48 49 50 51 52 53 54 55
node 1 size: 387055 MB
node 1 free: 338204 MB
node 2 cpus:
node 2 size: 3033088 MB
node 2 free: 3032998 MB
node 3 cpus:
node 3 size: 3033088 MB
node 3 free: 3032998 MB
node distances:
node     0    1    2    3
   0:   10   20   25   35
   1:   20   10   35   25
   2:   25   35   10   20
   3:   35   25   20   10
[root@localhost ~]#
[root@localhost ~]# /home/anton/Linux/mlc
Intel(R) Memory Latency Checker - v3.13
Measuring idle latencies for sequential access (in ns)...
                Numa node
Numa node            0       1       2       3
       0          82.3   147.6   173.8   238.0
       1         146.7    82.0   238.7   172.2


The Goal:

1. There are two tiers, fast tier - numa node 0; slow tier - numa node 2
2. Keep fast tier 50% free
3. Demote valkey inactive >=5 min pages from fast to slow tier
4. Promote valkey hot pages from slow tier to fast tier immediately
when accessed
5. Demote and Promote bandwidth performance limit up to 8 GB/s; CPU
performance unlimited
6. Monitoring intervals for Demote/Promote 500ms

What I already done -

Launch Valkey Pinned to Node 0 DRAM

numactl --cpunodebind=0 --preferred=0 valkey-server \
  --port 6379 \
  --protected-mode no \
  --save "" \
  --appendonly no \
  --maxmemory 300gb \
  --maxmemory-policy noeviction &


Command to Load ~200+ GB

memtier_benchmark \
  -s 127.0.0.1 -p 6379 \
  -t 16 -c 16 \
  -d 10240 \
  --ratio=1:0 \
  --key-pattern=P:P \
  --distinct-client-seed \
  --key-maximum=20000000 \
  --pipeline=32 \
  -n allkeys


[root@localhost anton]# numastat -p $(pgrep valkey-server)

Per-node process memory usage (in MBs) for PID 5631 (valkey-server)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.11            0.00            0.00
Stack                        0.03            0.00            0.00
Private                 238356.61            0.46            4.82
----------------  --------------- --------------- ---------------
Total                   238356.75            0.46            4.82

                           Node 3           Total
                  --------------- ---------------
Huge                         0.00            0.00
Heap                         0.00            0.11
Stack                        0.00            0.03
Private                      0.00       238361.90
----------------  --------------- ---------------
Total                        0.00       238362.04


damo start \--numa_node 0 --monitoring_intervals_goal 97% 3 5ms 10s
\--damos_action migrate_cold 2 --damos_access_rate 0% 0%
\--damos_apply_interval 1s \--damos_quota_interval 1s
--damos_quota_space 8GB \--damos_quota_goal node_mem_free_bp 50% 0
\--damos_filter reject young \--numa_node 2
--monitoring_intervals_goal 97% 3 5ms 10s \--damos_action migrate_hot
0 --damos_access_rate 5% max \--damos_apply_interval 1s
\--damos_quota_interval 1s --damos_quota_space 8GB \--damos_quota_goal
node_mem_used_bp 99.7% 0 \--damos_filter allow young
\--damos_nr_quota_goals 1 1 --damos_nr_filters 1 1 \--nr_targets 1 1
--nr_schemes 1 1 --nr_ctxs 1 1

And it is demoted much more, almost all pages than the goal of 50%
free numa node 0.

[root@localhost anton]# numastat -p $(pgrep valkey-server)

Per-node process memory usage (in MBs) for PID 5631 (valkey-server)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.02            0.00            0.09
Stack                        0.02            0.00            0.01
Private                  24389.88            0.46       213971.55
----------------  --------------- --------------- ---------------
Total                    24389.92            0.46       213971.65

                           Node 3           Total
                  --------------- ---------------
Huge                         0.00            0.00
Heap                         0.00            0.11
Stack                        0.00            0.03
Private                      0.00       238361.90
----------------  --------------- ---------------
Total                        0.00       238362.04

I just want that demotion process to stop when there is 50% free at numa node 0.

Where am I wrong, how to fix that ?

Anton
