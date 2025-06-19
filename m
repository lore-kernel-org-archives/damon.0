Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863F1E7C2D;
	Thu, 19 Jun 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351599; cv=none; b=CnzgiA+owskFN7sniakW0+DZkmCoXTNBySUhCMWaMCgGitnAYYjQ+1ScQG1UZ+UkXprCFazUTh8m9Eu7RZ/mn6IgRO1Y+siUAh+MS+EL4Ypce/Earz8kMHAcA4JesyYWpnkUpZmyyi1sqSzk8qo4lfvAPsEnxkL56h7m9MfmRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351599; c=relaxed/simple;
	bh=6AofT9ESYtvzpKrunVUzggzgj28w/qQmVkafxRW5TS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJzsrPDv/rSn00fSt8OW3bDYza/OirTnf9gtMzMvL6BAQPlIg410N85q5QqRbuEIT5A7VzfWKZ1rV6eK7mPDf6nw05tlTfH0GHp3Gi0hQKHJ8vDZy5ncIGda1rJt/KSdM08IL2ZK66rZw9THSgSuCP69KOZHp//CI3XtfL/QDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIDO0tcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIDO0tcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19DEC4CEEA;
	Thu, 19 Jun 2025 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750351599;
	bh=6AofT9ESYtvzpKrunVUzggzgj28w/qQmVkafxRW5TS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIDO0tcDxPmmcC8RlZqRNMtLv7u4CeIS7PaTzZD73oiYAflzD78CM142D4UMLlmTp
	 KCrlFeBu5HkhGq68TEF6zp5sx/wmSkPsUBFFhraBS9YRLRO1n5ZdZet+VmQdYcIId0
	 cKYmFW2WVDKWytREBsqLW/fdxLCENXRYQsX/vEaohlWWwdaItHKjoDkfwxmt9O6XSu
	 9y6Ml9feKgYh5Iyc14B6nO0YktS3zu5dEPxxBDteUB9YP8dwazbWj/xy7CzGnDDSRI
	 +RLFAFAsdhyq3vdck/ABRXW6XlPKRUUFcBQGCLXPe76+BLYWcECibEcP7e4hwEVQ+G
	 +N5zAisWJh0dA==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH] samples/damon: add parameters for node0 memory usage
Date: Thu, 19 Jun 2025 09:46:36 -0700
Message-Id: <20250619164636.58743-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619050313.1535-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 14:03:12 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> This patch changes the hard-coded quota goal metric values into sysfs
> knobs: `node0_mem_used_bp` and `node0_mem_free_bp`. These knobs
> represent the used and free memory ratio of node0 in basis points
> (bp, where 1 bp = 0.01%). As mentioned in [1], this patch is developed
> under the assumption that node0 is always the fast-tier in a two-tiers
> memory setup.
> 
> [1] https://lore.kernel.org/linux-mm/20250420194030.75838-8-sj@kernel.org/

Thank you for this patch.  Please note that this is just a sample code, and
hence there will be no strict user space compatibility support.

> 
> Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
