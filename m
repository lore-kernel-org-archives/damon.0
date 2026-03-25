Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037B2857C7;
	Wed, 25 Mar 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450715; cv=none; b=iMFzhKBbEmXR7FupDbHdHTU9kXrRSbDydheFh1RxFG+/UkMh7In1nDCDvS2ju5oDCxQ3WL2T99eUieF04qTsBqpFG6TSw61ch7FuEh1xr3Zql2Q4SIVZnRrrFgrioU86h1iInfzc9rJf3Y9aD++Quq/3F05aeVVlrAsk+ZYgITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450715; c=relaxed/simple;
	bh=5VPo4Xz6qxiaSF1DeT+HopouvLgzZgCEx7q/c9OS0g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzISdg1Bh5fx/7Pl/EOuog7+FFXQaCqMFOu3issxHqS8BB54iCztmzQx5+lW3EhKvqnuWKIBNynZmZHawi0jYXrtCJ5i7UfPHAmedsKwdecEqEhVtjyQiWw8gGw0KUJPfWNJVOFaqQaX5hP72GCR1aEu9H4E2ScXN70tUKgU3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5rpiVQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5rpiVQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74791C19423;
	Wed, 25 Mar 2026 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450714;
	bh=5VPo4Xz6qxiaSF1DeT+HopouvLgzZgCEx7q/c9OS0g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5rpiVQazkVl+/Uf4hxeNzefvz1dscY0p6VIOCZRkcRAUdT6xjC9m5Q3ZmGOs4Acz
	 rgB/QXWWqACD01Jo2GbD/bB2b22Qqfo0frdC/+7WnK4KMTyxJ9yMI7FEW74WeUvzeF
	 xkTD3aeoT+NsQ4Dw/5gRXYoG4Qj5gDpN2eQ14GfLPEBb7wr2c3EtUzJHuJe2y+E6Kz
	 lv/5J5M0oqc3PGbyYc5b0zALZ9tDUQOOuPb34HIWwk+zrFSqxirCWzhgJ31pvclFCB
	 wC+UDLBX093gQOuDevYXEvxKT9XJ2DNOekzbo8S4JgX7iW8Dpze/PP75qq+QTuunt0
	 8lEgjq9OAISMg==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko status) [PATCH 0/3] mm/damon/core: small cleanups
Date: Wed, 25 Mar 2026 07:58:26 -0700
Message-ID: <20260325145827.88239-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325073800.141756-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260325073800.141756-1-objecting@objecting.org

- [PATCH 1/3] mm/damon/core: deduplicate scheme index lookup into helper
  - status: Reviewed
  - review: No issues found.
- [PATCH 2/3] mm/damon/core: use damon_nr_regions() in damon_commit_target_regions()
  - status: Reviewed
  - review: No issues found.
- [PATCH 3/3] mm/damon/core: move last_nr_regions from static local to damon_ctx
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260325073800.141756-1-objecting@objecting.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
