Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C02AD00;
	Sun, 29 Mar 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798429; cv=none; b=CXtk0A3ZVTWvJW+GaeAd820hDr2/3Bb3Ct3YT5/2TX0HaG0DUazK2cuoZwWJ6w27YgfvR4TXVeTdCG/ahiRcNcyL6hWHbNbq3fdYiNwqTdhTAeUHRo7eFvpWUckr1WhKL1gvyWGzxyPznVxZ/lnLSgyHeKDmAZJgJnBqSYrUnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798429; c=relaxed/simple;
	bh=UQZPnV7y0W6fAjqQLaYQLOo7olw+e+13QhFuEevENgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ5Li/5iz++GBYeaqvEXOlE/OrgU+Eu0sAisF5J8Qn9JtoIDhKIDkoHEWSU5OGyrQ5jQpd1GoZYrjq97eXoaqniVOsqkOh8TCELC9HwNqefiypF8l5+4WN2rK7SM9MCJqaXg+adKi+4GR9F5VwNaUBn6DeYqk63EOSmRNjBEBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKlaSMtr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKlaSMtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A57C116C6;
	Sun, 29 Mar 2026 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774798429;
	bh=UQZPnV7y0W6fAjqQLaYQLOo7olw+e+13QhFuEevENgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKlaSMtraqBGZgzWHbvU99LPd9sjizXZe0IhKXcSdp1fbif3Si1gLR1s/HtZgkQXd
	 l30rRvOe7odaVZ7xKzGkprRRMsSc8D0sizhMjPmmy5gj2Nj7ifMf+spoDIoDmVRzoG
	 mJX8+WPxU3UsV0zlWpX42U2xcXYy/CkHMcx4x+wd7IH/1rWV7tWQ8kE/aizrrIRu5T
	 ZVfVvUulLdddbFk+VIMaqDa5EvPk9ktDhmjJyRSbTL14FtnNley89Ve+deB7O5JSCT
	 L8xWt/q4qdaLCCY3MHE1Yu6BXwnWi7/pfJZRJ7d0yO5HQyajtNA0PPS5YasnhVlVdZ
	 Mhy6YSWGHkqag==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Sun, 29 Mar 2026 08:33:45 -0700
Message-ID: <20260329153346.46881-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329043902.46163-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260329043902.46163-1-sj@kernel.org

- [PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
  - status: Reviewed
  - review: ISSUES MAY FOUND

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260329043902.46163-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
