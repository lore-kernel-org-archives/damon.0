Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E111CBD
	for <damon@lists.linux.dev>; Mon,  8 May 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AC8C433D2;
	Mon,  8 May 2023 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683582021;
	bh=oANPd3DOs4qD/lyqQBdBplr1++MgwupwWRZ+vdH1m90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7crJzFpVf5vcR2RJIAYclhXhh60hTtGH+ZKWXR2a5WCq2JnAdlu65p7hDRzEgmGp
	 kMiXy1eEv1hBPiKKY4DkP6EIsF25tTVPnHsXv4kwzsjJ3UT/4Dkzf9IRtkSlAuC87A
	 sKnvLMiILOCWFgCNwWE6zUoOjeh0GHjr4NAQypq2jwx8zcF0w2wLjHl3fA2B1vMbz0
	 NLJHk6+chVm3cFXnvPGdEL/IxAUIAhZ54PEYScT1ZURARfI0rNzMAhaTYCeSdF96Q2
	 LJRFo22DPHGDX3WCp2osv/Go8zXUUHSZNFSXFadOzAHQoa7MD2tcad/MOsu74WPfbi
	 MYnVEn+wSrlUA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
Date: Mon,  8 May 2023 21:40:19 +0000
Message-Id: <20230508214019.80558-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214003328.55285-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 14 Feb 2023 00:33:28 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi all,
> 
> 
> DAMON has merged into mainline as a data access monitoring tool that equips a
> best-effort overhead-accuracy tradeoff mechanism, and then extended for data
> access-aware system operations.  I'd like to briefly introduce current state of
> DAMON and share/discuss about 2023 plans including below.
> 
> - Finer and easier-to-use DAMOS tuning
>   - tuning aggressiveness based on user or kernel feed (e.g., QPS or PSI)
> - Merging DAMON user space tool into the mainline
> - Extending DAMON
>   - Page-granularity monitoring
>     - LRU-lists based page-granulariy monitoring
>   - CPU-specific access monitoring
>   - Read/Write-only access monitoring
> - More DAMON-based Operation Schemes
>   - Tiered memory management
>   - THP memory footprint reduction
>   - NUMA balancing
> 
> I hope to hear concerns/interests about the plans for prioritizing each work
> items and get some suggestions of future works and collaboration with other
> kernel subsystems/hackers.

We will start the discussion after about 1 hour and 20 minutes, so sharing the
slides here:
https://drive.google.com/file/d/10nsd4fq01On9p-oTmCS5KSW6qESmB6ER/view?usp=sharing

The link might be changed later.  I will update on this thread in the case.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
