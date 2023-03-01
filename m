Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22D7F0
	for <damon@lists.linux.dev>; Wed,  1 Mar 2023 00:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F226C433D2;
	Wed,  1 Mar 2023 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677632123;
	bh=voMkNK1f6oVYmLyyFA6E1CLB/bXoNzaI4PWC7kFH4zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLnGKyZdLjtE6Xe4SeVIOyEwpRETIj8W0uctOJnG5a0TXPZYz82Y8doA3oXz4OTKw
	 Rr4y9O7spms9jhNekJwnty4drAo1gxZ2j/Q+t3uJh/Idrpg1qzssSkfYWh9FZocRCG
	 VwLp/CEet3GyCkvu52zc5PARcInP7cPOo4hCzD1Xx8cYYu2IoHsRd5cIeZJN1aiOIL
	 xJoZjuYIjBgGzy1VZpAeRgxmLyW4OGKDnnsLbUiSABFFBUd50ZiGUdpErJbQyyKy+F
	 OpBYPlXzi6KFkNlMn7Ie3XufX/hDl/LOiwH635dZInnmsd5qP1XfQpIVFQnigNS+vR
	 HWtUSQpfaelKA==
From: SeongJae Park <sj@kernel.org>
To: "Pulavarty, Badari" <badari.pulavarty@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
Date: Wed,  1 Mar 2023 00:55:21 +0000
Message-Id: <20230301005521.78027-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DM6PR11MB397833DB2DF869EB50D5E92F9CAD9@DM6PR11MB3978.namprd11.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Badari,

On Wed, 1 Mar 2023 00:24:54 +0000 "Pulavarty, Badari" <badari.pulavarty@intel.com> wrote:

> Hi SJ,
> 
> We discussed this earlier. 
> 
> - Are there plans to make DAMON monitor/manage cgroup instead of individual pids? 

Yes.

For moniroting cgroups, there are only rough ideas at the moment, and no much
progress has made so far.  I hope to discuss about real needs of this feature
(I didn't make much progress here mainly because there was no many people
pushing this) and the best way for implementing it during the session if
possible.

For monitoring-based memory management of cgroups (via DAMOS), however, DAMOS
provides cgroup-based management action target memory filtering[1].  Using the
feature, you can do cgroups-based access-aware memory management.  The patchset
has merged into the mainline a few days ago.

[1] https://lore.kernel.org/damon/20221205230830.144349-1-sj@kernel.org/


Thanks,
SJ

> 
> Thanks,
> Badari
> 
> -----Original Message-----
> From: SeongJae Park <sj@kernel.org> 
> Sent: Monday, February 13, 2023 4:33 PM
> To: lsf-pc@lists.linux-foundation.org
> Cc: SeongJae Park <sj@kernel.org>; damon@lists.linux.dev; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
> 
> Hi all,
> 
> 
> DAMON has merged into mainline as a data access monitoring tool that equips a best-effort overhead-accuracy tradeoff mechanism, and then extended for data access-aware system operations.  I'd like to briefly introduce current state of DAMON and share/discuss about 2023 plans including below.
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
> I hope to hear concerns/interests about the plans for prioritizing each work items and get some suggestions of future works and collaboration with other kernel subsystems/hackers.
> 
> 
> Thanks,
> SJ
> 
