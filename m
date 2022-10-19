Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726B4C72
	for <damon@lists.linux.dev>; Wed, 19 Oct 2022 17:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34240C433D6;
	Wed, 19 Oct 2022 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666200727;
	bh=j5op88tCtQJYSZcABrjvuLNqEi5MZTKsnk+JdLArf+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTrDtmlVNr2LSm472A9vSFy+P198V/su8VSou661enLYiKL6DuiO149uM0dMiVxvF
	 SKyZGXElT56ETi2brFrQ423OU3OvSt43WSC8uxFVGHb2tsZOgsSckx5DUa4YFQ8Tzg
	 gAbURZVeiO7egr1c1Q05I2hulDFa9RrZJe05vuKii2/XfXz/g/ofg8w7hS1skw5ul6
	 1JgClGV12xcOh1l1z1HlGKNphUiYP4MgnFcMR7LmuclRdDrvDbT6D6cCqQSOk6rg+n
	 83pEhULHUBZNfahhCfqFEJlWSQuQxjC3tVDKoNBlBAXbzVwvzyewkVYBR76/V+26uX
	 PtGRmNbchL1AQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/18] efficiently expose damos action tried regions information
Date: Wed, 19 Oct 2022 17:32:05 +0000
Message-Id: <20221019173205.85216-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019001317.104270-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 19 Oct 2022 00:12:59 +0000 SeongJae Park <sj@kernel.org> wrote:

> DAMON users can retrieve the monitoring results via 'after_aggregation'
> callbacks if the user is using the kernel API, or 'damon_aggregated'
> tracepoint if the user is in the user space.  Those are useful if full
> monitoring results are necessary.  However, if the user has interest in
> only some regions having specific access pattern, the interfaces could
> be inefficient.  For example, some DAMOS users might want to know
> exactly what regions were identified as fulfilling the access pattern of
> the scheme, for a debugging or a tuning.
> 
> This patchset implements DAMON kernel API callbacks and sysfs directory
> for efficient exposure of the information.  The new callback will be
> called for each region before specific DAMOS action is gonna tried to be
> applied.  The sysfs directory will be called 'tried_regions' and placed
> under each scheme sysfs directory.  User can write a special keyworkd,
> 'update_schemes_regions' to the 'state' file of a kdamond sysfs
> directory.  Then, DAMON sysfs interface will fill the directory with the
> information of regions that corresponding scheme action was tried to be
> applied for one aggregation interval.
> 
> Patches Sequence
> ----------------
> 
> First five patches (1-5) clean up and refactor code that following patch
> will touch, and the following one (patch 6) implements the DAMON
> callback for DAMON kernel API users.
> 
> Following six patches (7-12) clean up and refactor the sysfs interface
> before the new sysfs directory introduction.  Following two patches (13
> and 14) implement the sysfs directories, and successing two patches (15
> and 16) implement the special keyword for 'state' to fill and clean up
> the directories.
> 
> Finally, two more patches (17 and 18) for the documentation of the usage
> and ABI follow.

I think this patchset is unnecessarily big due to the cleanups and
refactorings.  I added them in this patchset mainly because I found the messy
code while working for the feature.  However, now it looks like it would make
more sense to split them out into separate patchsets.

Just thinking loudly, but any input is welcome.


Thanks,
SJ
[...]
