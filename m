Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B1274FE3;
	Thu, 26 Mar 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532537; cv=none; b=NgOefhxyF0MOjoc2NF8VR9WI0iAjFR539Od+g1FdwjqZb+zHYoVyDu+7aI0j9voUu3IUvSSLVEchFJsEuSONkcmLj+j7AUbkV/erzuWFWcIsGDLzI/xGDmS6dzK5PoAB6EkfF9VOkoBgN2R3kKK1xZcxYWJSvJIHexqr0j59mKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532537; c=relaxed/simple;
	bh=/ibWzeKxjNFBvk8wY+4Gkqhtda2oN8qXvu9dlbPEKXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU4blg2tRMUgZyHKqYbPGAigF9JtCp6tkZOGLkWR/DZ5tUU+VzZcAyoJVbdz27JfPjkw0FWNemUb6jlY7uT092q2uVa4tEoXprp/9x/RLEAsKJT9jqmK+XWLzktCLRLW82TP7T2c0wSpgnbUmX3Tqoy+Ntd79QON0wockUAQGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHgy518K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHgy518K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11C6C116C6;
	Thu, 26 Mar 2026 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532537;
	bh=/ibWzeKxjNFBvk8wY+4Gkqhtda2oN8qXvu9dlbPEKXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHgy518KsjFtwu8+Y9MEXkDzm78FGQR1H48i4sLEtgqPg7ntJb4eFGmGBsh03q0yL
	 sUI+oUxdApsJfW4l2Z7moz/Tt3aGu7McGtNPiPhYhiPxBEqcKIixXt8Xpe80VmS9Uu
	 3aSZUb0v2dlpxeDE5aIPOiix0OfaMs3KIk14CvBTumkBR0s0wRkZ3wLVzBxiPb6Bdz
	 O60p/Ldox2qQFxCZmtGmghEm0jxdyd2QJcyArIvIL7iolTnd8k3ITwuzqc9vI88CCX
	 eVRHYXzlqbpGw/yiUH/kdp8ovT3lih5fMNCgnS0GdJ0SbKOzTNb5/Qt3B5C2Z7avNM
	 4YvUhroD1mt8A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH 0/2] mm/damon: fix damon_call()-related leak and deadlock
Date: Thu, 26 Mar 2026 06:42:08 -0700
Message-ID: <20260326134209.90377-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326062347.88569-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260326062347.88569-1-sj@kernel.org

- [RFC PATCH 1/2] mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH 2/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
  - status: Reviewed
  - review: ISSUES MAY FOUND

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260326062347.88569-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
