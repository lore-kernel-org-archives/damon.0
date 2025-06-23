Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6D2581
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686355; cv=none; b=uT/Di469X0Qi4ImvLjwxTAkSa2gvvv9/k84nVTT3z10xpTCs6tlGmQdW62E53YqdmfwOb/Tlrpzz3Q7ErcC9WtmxN73aGMtk/AfQxyjpXLiA4i1w9HMjYFkgCpg4uLELM3TVG9sIusqdbVmFD0hI8A0uc8r1eP/G/CpIEYNQ6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686355; c=relaxed/simple;
	bh=GbjuxIKt7GEonaHrp5LL1AmZ9clyp72RW5FyRoGRkbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjtIgx3hqr9H1H4uGFaWimdjryxTOAWTpsUSIatK3u9VWhUTd3Huvs0sK/IXVavYXqo7eenuduTqX0iWZphzjVgXuGI11o37rkBe/nWMEKgR1MZfDgFmwkxhXVxC+3L6ipNZcqxV57g8a7wnLisNNeLQqmVPwz8rHLhvCUJZu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0g6CS6r; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0g6CS6r"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e447507a0so31122407b3.0
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750686353; x=1751291153; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSfF7un8LIQsGUb2HSbfU97hICuhPSaYsldpijdfOsQ=;
        b=W0g6CS6rorlB3yDnBfMmPYko9IYrGzRxdVrTj0BSFRja4mXFHE4EpIrJTf44oRXNcT
         MRqQc26vMOWPlwp0Gr374zKWRz3hejaR8XNSKvUXN5Nuw/6GariWoJGChVQWBbOCsIwS
         13sjRIWEEbjc1RjYDvWTjU2wQmOd4833yetXKB25yYyEZj5sEtDMCuU85FTz6mgHiek7
         zKbzaaZ1YaEELYLEj9FiCmZoaI4bDrFSPHp324T9Ys9DCIWOV0azwUMRFgDONh1NZyjy
         t5Q9C39OaytEf5s9ov8K/8+XeNzYnzGs86SrhrHnAskMIaWFDQoLhSmG9Ut+Yiozo790
         8Z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686353; x=1751291153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSfF7un8LIQsGUb2HSbfU97hICuhPSaYsldpijdfOsQ=;
        b=BsIMOjaBDs1/FnRP1ueyKLjm6JZ4XXMDTueN7wNCXLQIv4eODLWNXw2Axw7MGR8+az
         63XM3zFVweuUe7It7T6utnUI2bmQEy/BB4uUkdh46IUc6MLpbGMI6Pdmgg/a7YnSyS55
         EpR2RmTLd3p+n+sqAK0zmdRs40aN4KxLtmVlJdMkvKS6DSPF+iqJx1SCdLRJLZZcHphX
         hd0vWRMeVckkDJgjyUj4XvV8WShnyJ6xUmZ+Z5ldeeIC+nXDO3ccS/Px/ZHz8XFQcAPf
         Z0O7122QC4WAUIX/JxdwkuBQPbDhfSwoudQIM+MaROF1N0kdRQTVgmy/yi6tLGX4TTVH
         v1Ng==
X-Gm-Message-State: AOJu0YxviSCccyQbEm+t4Um7+RsCuKIzOs7fiAw685PuFjL3UtyA7X+p
	il08UaXAtVa/w2ClI/3PACxAm4FYRVuut40enlqGkkAbSagEuCOVIrSG
X-Gm-Gg: ASbGncvj1lJUeoNhlDzSCvShY5Mmb5uPxpHFqDwns0tvDjEgT/ZLfLQ7UKaLN1UZuG7
	6a+kGMd2pz1shc8eNucmOrN5WRgSqhyEQ5HHdgxh+Kst5wFur11u4xiCbXSJfceJgnprHMDnffz
	YSF0e8LYCrk3OMSvdhqjPYKZXbo0KQ9Z2PDPrfWzcdLFbtDVNL/95N9BRrD6DdUs3f107mZLW7D
	Uw8YLOyty9DGjkFdQKYFAzb8equ85J+4yBiH2xb+s73CMcq1e2H7gqkMfDgD5hFJW+ReiAwmlFd
	VswI5oruZP5QijaBcLtXIlSE/l+Zzu8xxS/rCcQiOOd7OSRXnfxuNpj/FHjz/w==
X-Google-Smtp-Source: AGHT+IG38eDF3uDJCo+9jSrUa+GIdCMuLehbCwzqrSlA2tsKSYXh5jQni+GVNFRrtzz7ofvR3E00YA==
X-Received: by 2002:a05:690c:7345:b0:70c:a5c2:ceed with SMTP id 00721157ae682-712c65128a7mr173679777b3.25.1750686352703;
        Mon, 23 Jun 2025 06:45:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4b96502sm15855337b3.79.2025.06.23.06.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 06:45:52 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sj@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in migrate_{hot,cold} actions
Date: Mon, 23 Jun 2025 06:45:49 -0700
Message-ID: <20250623134550.2367733-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250620180458.5041-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 13:04:56 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

Hi Bijan,

I hope you are doing well! Sorry for the late response. It seems like SJ
already gave some great feedback already though, so I will just chime in
with my 2c.

[...snip...]

> However, currently the interleave weights only are applied when data is
> allocated. Migrating already allocated pages according to the dynamically
> changing weights will better help balance the bandwidth utilization across
> nodes.
> 
> As a toy example, imagine some application that uses 75% of the local
> bandwidth. Assuming sufficient capacity, when running alone, we want to
> keep that application's data in local memory. However, if a second
> instance of that application begins, using the same amount of bandwidth,
> it would be best to interleave the data of both processes to alleviate the
> bandwidth pressure from the local node. Likewise, when one of the processes
> ends, the data should be moves back to local memory.

I think the addition of this example helps illustrate the neccesity for
interleaving, thank you for adding it in!

> We imagine there would be a userspace application that would monitor system
> performance characteristics, such as bandwidth utilization or memory access
> latency, and uses that information to tune the interleave weights. Others
> seem to have come to a similar conclusion in previous discussions [3].
>
> Functionality Test
> ==================

[...snip...]

> Performance Test
> ================
> Below is a simple example showing that interleaving application data using
> these patches can improve application performance.
> To do this, we run a bandwidth intensive embedding reduction application
> [5]. This workload is useful for this test because it reports the time it
> takes each iteration to run and reuses its buffers between allocation,
> allowing us to clearly see the benefits of the migration.
> 
> We evaluate this a 128 core/256 thread AMD CPU, with 72 GB/s of local DDR
> bandwidth and 26 GB/s of CXL memory.
> 
> Before we start the workload, the system bandwidth utilization is low, so
> we start with interleave weights biased as much as possible to the local
> node. When the workload begins, it saturates the local bandwidth, making
> the page placement suboptimal. To alleviate this, we modify the interleave
> weights, triggering DAMON to migrate the workload's data.
> 
>   $ cd /sys/kernel/mm/damon/admin/kdamonds/0/
>   $ sudo cat ./contexts/0/schemes/0/action
>   migrate_hot
>   $ sudo cat ./contexts/0/schemes/0/target_nid
>   0-1
>   $ echo 255 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node0
>   $ echo 1 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node1
>   $ <path>/eval_baseline -d amazon_All -c 255 -r 100
>   <clip startup output>
>   Eval Phase 3: Running Baseline...
> 
>   REPEAT # 0 Baseline Total time : 9043.24 ms
>   REPEAT # 1 Baseline Total time : 7307.71 ms
>   REPEAT # 2 Baseline Total time : 7301.4 ms
>   REPEAT # 3 Baseline Total time : 7312.44 ms
>   REPEAT # 4 Baseline Total time : 7282.43 ms
>   # Interleave weights changed to 3:1
>   REPEAT # 5 Baseline Total time : 6754.78 ms
>   REPEAT # 6 Baseline Total time : 5322.38 ms
>   REPEAT # 7 Baseline Total time : 5359.89 ms
>   REPEAT # 8 Baseline Total time : 5346.14 ms
>   REPEAT # 9 Baseline Total time : 5321.98 ms
> 
> Updating the interleave weights, and having DAMON migrate the workload
> data according to the weights resulted in an approximately 25% speedup.

Thank you for sharing these very impressive results! So if I can understand
correctly, this workload allocates once (mostly), and each iteration just
re-uses the same allocation, meaning the effects of the weighted interleave
change are isolated mostly to the migration portion.

Based on that understanding, I'm wondering if a longer benchmark would help
demonstrate the effects of this patch a bit better. That is, IIRC short-lived
workloads should see most of its benefits come from correct allocation,
while longer-lived workloads should see most of its benefits come from
correct migration policies. I don't have a good idea of what the threshold
is for characterizing short vs. long workloads, but I think this could be
another prospective test you can use to demonstrate the gains of your patch.

One last thing that I wanted to note is that it seems like iteration 5, where
I imagine there is some additional work needed to balance the page placement
from 255:0 to 3:1 *still* outperforms the normal case in the original
benchmark. Really awesome!!!
 
> Questions for Reviewers
> =======================
> 1. Are you happy with the changes to the DAMON sysfs interface?
> 2. Setting an interleave weight to 0 is currently not allowed. This makes
>    sense when the weights are only used for allocation. Does it make sense
>    to allow 0 weights now?

If the goal of 0 weights is to prevent migration to that node, I think that
we should try to re-use existing mechanisms. There was actually quite a bit
of discussion on whether 0 weights should be allowed (the entire converstaion
was split across multiple versions, but I think this is the first instance [1]).

How about using nodemasks instead? I think that they serve a more explicit
purpose of preventing certain nodes from being used. Please let me know if
I'm missing something as to why we cannot use nodemasks here : -) 

[...snip...]

One last thing that I wanted to note -- given that these weights now serve
a dual purpose of setting allocation & migration weights, does it make sense
to update the weighted interleave documentation with this information as well?
Or, since it really only affects DAMON users, should we be ok with leaving it
out?

My preference is that we include it in weighted interleave documentation
(Documentation/ABI/testing/sysfs-kernel-mm-mempolikcy-weighted-interleave)
so that anyone who edits weighted interleave code in the future will at least
be aware that the changes they make will have effects in other subsystems.

Thank you for sharing these results! I hope you have a great day :):)
Joshua

[1] https://lore.kernel.org/all/87msfkh1ls.fsf@DESKTOP-5N7EMDA/

Sent using hkml (https://github.com/sjp38/hackermail)
