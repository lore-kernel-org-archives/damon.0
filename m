Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5827C34C815;
	Sat, 28 Mar 2026 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774664976; cv=none; b=dz9bZOG1ImCAogYojanopnqXY6XQ9IL7lv79mj8LLQcx7o+7pctVYDKasfZAEzFKXKZin7PtBND1ZWSs23kGVmqT7pE/RtdM+ZmcnQpNDiZ+RSQRp99Ut+cFp1SPR+KBdNTqUvOEmzaBpsN0iW6rNLbOV7DXIdtxa4Wm88HS9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774664976; c=relaxed/simple;
	bh=KIRDEFAguIVpfVlhSaHcJ5jZR8gN8as3jIvYc9PGgXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swfnWrmY8NWmyYw7whwiJnSYC0Xc1DYesjltYEQt4aXuESpOLzmMxDxEdbghf9A2xBqmwmjtQRwYPTwhzFYqvqP7GcJxMmeV1cyPv2LQE35G9EkGX7qNBZZ6mRAdLrb1eg8ZDadlknx5xyAxQt6VKYs6xjLBdp1xVJ6P2AnZYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miGLYYay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miGLYYay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4EBC19423;
	Sat, 28 Mar 2026 02:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774664976;
	bh=KIRDEFAguIVpfVlhSaHcJ5jZR8gN8as3jIvYc9PGgXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=miGLYYayVCNceD2OXh6QKBXfU8CTnJl+b82BkRUhaTA/k6ODzrOx0b8TEYV0KJ0oX
	 se8k4zWiFyYxURTNC7XQOx47yhsvrGdMnxgevVZdxzO/DK+EX+2e0FVhUOTlwrsnEG
	 tzY/bId9pELVkvNagx8DzwA82BJzfEoQYuEOfa1OrirgXu5kn6xf8LOmMAodyQftry
	 hNh28or2L08B/b/KdvVHMqnIHOtyAcavnWDfKnH1XD8oVs4Pm6kmLQMOU6JTMMTeeR
	 t+pbE/OlFTnTEcMKvJgbtu0i2ZzYMpModYejXbu/hQwLdWZSlTfqzzukz61Vc8uqvZ
	 WqV67lgCxPS+Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Fri, 27 Mar 2026 19:29:33 -0700
Message-ID: <20260328022933.8306-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328005412.7606-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260328005412.7606-1-sj@kernel.org

- [RFC PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
  - status: Reviewed
  - review: ISSUES MAY FOUND

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260328005412.7606-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
