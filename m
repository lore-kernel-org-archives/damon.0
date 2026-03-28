Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8670AD5A;
	Sat, 28 Mar 2026 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658570; cv=none; b=cmpOJBvW4dj+o0YQcq4uzQnzd1heBGMaVzOEUbnCVMLj0Gdj2QPXRJCGXgpyxx9yVcUeVSqeECEq1XkCdYEilqpuLGzVeFef3sCWs1ZFBveCBoV2SNRMPnXZNEHRdG6X8BGeCbepl+aoBOW3S+E+3BuxJ0AmgdpppHg81eR+XjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658570; c=relaxed/simple;
	bh=tHes9tujM299r1urFSferkNbsuKXc5jy+H3o7lTRdJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7gQ1kZfh/CRsQbM2X4NyZEG956gPaK29qzuGMWSJyWflHj++JFMFTyLsRcVpBuF7FhWvuIq7YyDpH4Fdym56DeFtVfSwCrgoF26wS2HFAWIUiFidHUQNsYXZ1dke9EKWbOQXpnC2SLZ8r00wiHHdA+IDSHb9LsTqMuUPp1yc0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIQtZgA2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIQtZgA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C3C19423;
	Sat, 28 Mar 2026 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774658570;
	bh=tHes9tujM299r1urFSferkNbsuKXc5jy+H3o7lTRdJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIQtZgA2OfkDInqDspKtfTq6oZwEBuFw1b2Bb3qBuqJEzI+9tRXVNkRd59vntaQvb
	 +t304fg1jVcAGb/hg5iIWKI0P13043WPWATwdg/LbXMpnEi6mQq5CAcult9oNJg9fQ
	 S1nxOHCKtQEKW62Hz6PDfUMLGVefT4kF93T7fp9e7OdCo47Dlfs3xDTmSvcwkq2B/1
	 TuwPpUrUsHItrlTe0Iw4FEibeCEqLK3Qa9ka+yv2P8IibElytBJ8UrPe8g7ZpGkQAg
	 OF/Cy5Y0Mal1pyCKx4OPAHI04Psdk1VP61gxd/V6GDQxrH9K1LY7Wtrnaos+1aPn3A
	 PU29NlSAoHOLQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] mm/damon/core: fix damon_call()/damos_walk() vs kdmond exit race
Date: Fri, 27 Mar 2026 17:42:48 -0700
Message-ID: <20260328004249.7135-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327233319.3528-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260327233319.3528-1-sj@kernel.org

- [PATCH 1/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [PATCH 2/2] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260327233319.3528-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
