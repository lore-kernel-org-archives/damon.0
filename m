Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B77396D35;
	Wed, 25 Mar 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483172; cv=none; b=Wvrlm9hsHrZyLzwswb28IHuPyImzKXAuGBPv1PK3xuEzh6zQAa+HbssM+FaOmr1T9DLj7mBUbk6lB8vKRA/tYMal7Aru18dbpBNVDo/pJlhnnwgl6ucwECtrarNeQZLW6W7vnEiC3fOyPaxnSpsgEeZ+5RHsxqdatcFQNh69OZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483172; c=relaxed/simple;
	bh=Ia+YtXVLsyftT2gQjhtcxVdiFisfZe6MrM3hQLVJS/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeNDEVzayQdxYaIXRB16m9G/ktZzXGsZE9gtW3bq/pNbky4MJhBgs7KEXsNHEoZf85R81EaUHsUmPM+UsQgAXED/EmXBku9xe/EhErfGEGy92mm/HeqIydsgGN2BtNbSrnbw4CqKWf3mgD61l69MJO0ordk4vvyDXOO1OmoDCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfI7TnYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfI7TnYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C412C4CEF7;
	Wed, 25 Mar 2026 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774483171;
	bh=Ia+YtXVLsyftT2gQjhtcxVdiFisfZe6MrM3hQLVJS/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfI7TnYVxBB8YFjdv6ubD4x/YqmK9rNwmFtuovjFyEFXhdVvFVcgXYhB7mengXFVS
	 CoAnoRdKS75d0n8EMgmV9G/Mnh2KMiCk399SvwoxAkz5DqqB/nxh5AGp+mMQaQMbBR
	 DYUG+YCkz4hjL+X82HFJFBx5NrfU7ypDn/O+cff1ElCSSTwWGGD5x1bgyn0aCB9e+3
	 KcXQ6yPCk8+b1PKNsPvkIcmRV43Uhwo416oSo2xlLnwrxnBGon7gbZZKLOC3eWXhkE
	 HYNf0reHugTzcpz4IroYwtesCkccT6tEqKKLYnTw2AiAL183vrcBbzflrw+gmaVs5L
	 nS7dZk90Ic8jA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko status) [PATCH] mm/damon/core: deduplicate core and ops filter commit functions
Date: Wed, 25 Mar 2026 16:59:28 -0700
Message-ID: <20260325235928.76076-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325204250.254364-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260325204250.254364-1-objecting@objecting.org

- [PATCH] mm/damon/core: deduplicate core and ops filter commit functions
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260325204250.254364-1-objecting@objecting.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
