Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7DC14A089;
	Thu, 13 Jun 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300769; cv=none; b=a1jM0Ear4Pb+gzEMz/dN/V/5If59pz8opRqRIxi/9Myhqm+BKsTkBYWgYGs5ENgadxvVEReWS9i2RJhpvtHPludRn3owR05WU0t1O53fShUFHxX8U08qQIzyxmelvp60L2CK2x4P9lvxiggX29r57ziSts6i9oT0Y3crjlPBoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300769; c=relaxed/simple;
	bh=2xnDcVWPpc4uuyAJqazQ/b3kOV5JH1ETZDCMyQNsypo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REZy+UJVqAHHLo3IhO9BVfARe9VWEm7EYWZJRG977DFFMj0JHBcCBDVcSUYo2abviN/DrWg1L1aCuEBW/pMHGMX6ZqLG2KeKlcL+IAroTy7mDy5DiIt31jEMMBLtCzDr64X11KDFGMlKyRUO+YUpGVxEALfDETVUSwXs6vw2w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmmo3kTk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmmo3kTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03FAC2BBFC;
	Thu, 13 Jun 2024 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300769;
	bh=2xnDcVWPpc4uuyAJqazQ/b3kOV5JH1ETZDCMyQNsypo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmmo3kTk6tF9BXrVmVWjY1p5n6Pd446uMdNoBChrb4ymvL901wCvMoCoKvNddFlnR
	 fDflClD/H2Fm5xPdLL7GIPyPtY2b4TWPo/lhP3rm06Zv1D1TAejbA9KMdaXWALKPoL
	 VreIDaSBz1gBMPumkK5lJIHgAE4RYLctYX+eAUzW0/zjbFJoml7HsuprIHRDLbK0lZ
	 JzUICyUy3c1n16Ncz+eYTobvyIhiQrcdn61YJGUINrN4PS3QtxRSiLLk/4NtCI4zvu
	 x9qszP68I701jdUHGB8q6u+pjR7I82JLJcMJU4ulb31MviqOEzGUSosikPqBDZY7Dm
	 +XYO0kr9/4U+Q==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH v5 0/8] DAMON based tiered memory management for CXL memory
Date: Thu, 13 Jun 2024 10:46:04 -0700
Message-Id: <20240613174604.63629-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Thu, 13 Jun 2024 22:20:47 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> posted at [1].
> 
> It says there is no implementation of the demote/promote DAMOS action
> are made.  This patch series is about its implementation for physical
> address space so that this scheme can be applied in system wide level.
> 
> Changes from RFC v4:
> https://lore.kernel.org/20240512175447.75943-1-sj@kernel.org
>   1. Add usage and design documents
>   2. Rename alloc_demote_folio to alloc_migrate_folio
>   3. Add evaluation results with "demotion_enabled" true
>   4. Rebase based on v6.10-rc3

I left comments on the new patches for the documentation.

[...]
> 
> Evaluation Results
> ==================
> 
> All the result values are normalized to DRAM-only execution time because
> the workload cannot be faster than DRAM-only unless the workload hits
> the peak bandwidth but our redis test doesn't go beyond the bandwidth
> limit.
> 
> So the DRAM-only execution time is the ideal result without affected by
> the gap between DRAM and CXL performance difference.  The NUMA node
> environment is as follows.
> 
>   node0 - local DRAM, 512GB with a CPU socket (fast tier)
>   node1 - disabled
>   node2 - CXL DRAM, 96GB, no CPU attached (slow tier)
> 
> The following is the result of generating zipfian distribution to
> redis-server and the numbers are averaged by 50 times of execution.
> 
>   1. YCSB zipfian distribution read only workload
>   memory pressure with cold memory on node0 with 512GB of local DRAM.
>   ====================+================================================+=========
>                       |       cold memory occupied by mmap and memset  |
>                       |   0G  440G  450G  460G  470G  480G  490G  500G |
>   ====================+================================================+=========
>   Execution time normalized to DRAM-only values                        | GEOMEAN
>   --------------------+------------------------------------------------+---------
>   DRAM-only           | 1.00     -     -     -     -     -     -     - | 1.00
>   CXL-only            | 1.19     -     -     -     -     -     -     - | 1.19
>   default             |    -  1.00  1.05  1.08  1.12  1.14  1.18  1.18 | 1.11
>   DAMON tiered        |    -  1.03  1.03  1.03  1.03  1.03  1.07 *1.05 | 1.04
>   DAMON lazy          |    -  1.04  1.03  1.04  1.05  1.06  1.06 *1.06 | 1.05
>   ====================+================================================+=========
>   CXL usage of redis-server in GB                                      | AVERAGE
>   --------------------+------------------------------------------------+---------
>   DRAM-only           |  0.0     -     -     -     -     -     -     - |  0.0
>   CXL-only            | 51.4     -     -     -     -     -     -     - | 51.4
>   default             |    -   0.6  10.6  20.5  30.5  40.5  47.6  50.4 | 28.7
>   DAMON tiered        |    -   0.6   0.5   0.4   0.7   0.8   7.1   5.6 |  2.2
>   DAMON lazy          |    -   0.5   3.0   4.5   5.4   6.4   9.4   9.1 |  5.5
>   ====================+================================================+=========
> 
> Each test result is based on the exeuction environment as follows.

Nit.  s/exeuction/execution/

[...]
> In summary, the evaluation results show that DAMON memory management
> with DAMOS_MIGRATE_{HOT,COLD} actions reduces the performance slowdown
> compared to the "default" memory policy from 11% to 3~5% when the system
> runs with high memory pressure on its fast tier DRAM nodes.
> 
> Having these DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD actions can make
> tiered memory systems run more efficiently under high memory pressures.

Thank you very much for continuing this great work.

Other than trivial comments on documentation patches and the above typo, I have
no particular concern on this patchset.  I'm looking forward to the next
version.


Thanks,
SJ
[...]
