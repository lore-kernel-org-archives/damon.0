Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F875849C;
	Fri,  3 Apr 2026 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176042; cv=none; b=CC8gX+qchRt5ItAXuy5k0kyKShOtatUmZmP/AruNX1ZSMmA3kAPXmNygyYWv5FJawAAgLEQgDPloGBdkQBpCrzn79W79Z46onzDiPNmjYSinNM8g/JINPikfqhBHOmdtRTCmuqcBC45bDnhzLhQeY3AOh1Zc8gubbWn6Pje+W3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176042; c=relaxed/simple;
	bh=FAOmb0Y2QnL5Q8OwKXxRLtG/irKniaoNq15rFQ46vJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYRr/ZcV+T69kbt0MhxWks3AMMZiCaWK8YeZRzW7SpZjL7OWcjlLx6RQdF/gosSteFfEogkWyCUQ6PLAtRqFySIOMb1KYwxd5RrtxOhjSa7K36F7tpV3IHuaISg+Jolmz6GHaA3i+8QswOOGKHjt45qZOu7m1DRUzglyWwFj4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2PROhH2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2PROhH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B6C116C6;
	Fri,  3 Apr 2026 00:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775176041;
	bh=FAOmb0Y2QnL5Q8OwKXxRLtG/irKniaoNq15rFQ46vJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2PROhH2jnEOJuJiGfSMB2Ie2dj9C8i4DRhk/Aqeo0KMs0baIenige4web/BtD2lK
	 qdTPxIdmNMVBRzUzYyo72BW5dR/gOK0r8WEuvDdoxdPqMAY35+PHGPaPUug3uX4ch4
	 7DTDCuS+gZymytnetrpaEbFQZdeCOJcaJ1oo7MOmwBCwJgipfpo1eKTrTttgN3m2s0
	 hlpR7GrkOVKHLhPqPGIrDLX1WV3zLfO35jsDlk27YY71CUs1wCJ1nAxH3c/ZWMBF6R
	 4DnDPkIUFLu37nnZpabr8jvI4r5M+VBFZWiEV9WiOWMhhX9OIvu5GsF8PRsKISc7f5
	 kV7U9rFoVRGRQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/3] mm/damon: non-hotfix reviewed patches in damon/next tree
Date: Thu,  2 Apr 2026 17:27:19 -0700
Message-ID: <20260403002720.46601-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402155733.77050-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropping recipients who are not 100% surely interested in the sashiko review.

TL; DR: no blocker for this series is found.

Forwarding sashiko.dev review status for this series in a reply format with my
inline comments for details of why I say the TL; DR.

> # review url: https://sashiko.dev/#/patchset/20260402155733.77050-1-sj@kernel.org
> 
> - [PATCH 1/3] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
>   - status: Reviewed
>   - review: ISSUES MAY FOUND

No real issues here.  Read my reply to the patch for more details.

> - [PATCH 2/3] Docs/admin-guide/mm/damon: fix 'parametrs' typo
>   - status: Reviewed
>   - review: No issues found.

As the 'review' is saying.

> - [PATCH 3/3] mm/damon: add synchronous commit for commit_inputs
>   - status: Reviewed
>   - review: ISSUES MAY FOUND

No real issues here.  Read my reply to the patch for more details.


Thanks,
SJ
