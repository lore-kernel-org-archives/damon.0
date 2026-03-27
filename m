Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297C24B28;
	Fri, 27 Mar 2026 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774652247; cv=none; b=QnaXjPiNeae/1sdH++Ix1ZgRyqo0m2xiMhVIddYfuZY6gW9DXJJWHW2D0YiXTp1uSRQvNv07GyV87mjSzqMxvMSSvd7k+FCjnNLzirivZLa+ZL3Njlyfnms5p238PZIv+HzI84xEk3DFhQwTKTLCe/iExugbpNH2tqFsJsQOg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774652247; c=relaxed/simple;
	bh=1gPhvFFqtiKNhLFWqZxqekg0toLeQJ3oOjvtXV4w9q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Af/iCUUwByZrIBxFuKy17/TWeatQrptpJUcbO53iSyW/UMkYGm0cxCc7PlnKkIJ6wIGhIEtBhERhVk1iXvv8Prz6KJheejg4aVXS5nrVNXD9QI/+syx2q9fLRUmEJAFNOG3s+X7rGQPA+0b4HieQFMOPPoGOFDupw1PywmpqTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfWOM8eH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfWOM8eH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7640FC19423;
	Fri, 27 Mar 2026 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774652246;
	bh=1gPhvFFqtiKNhLFWqZxqekg0toLeQJ3oOjvtXV4w9q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfWOM8eHRZSguTkeM9uHdXD3MlFZ+g53dC0CbjaiWWcFZoomoCRIP8IPOGWP8ep7P
	 rvTj8clFtj9UwD9hGhdS/GM2Vcw4cPF6JG9XmHs2quvP+qzm/EzasUxvLok8PPPtL+
	 4OJAy6oe8YxWRNQpoiT8k+K3OplT7jOI+PIWU6mKLj1k6GIUX12Z6TDhCjusQwIjLt
	 vBcE+Mxp2uNs8y67WXeJ6GXEPFLkN8md5wIhluzbL3Kf8OUbbSk6PCXL1kjsdHxm0n
	 TBwmBDjgQH1rC31io6DEDrWH2+a6wS6aGIcHsxqJlkXvzbwpQyybiJtISlgDHYplUw
	 ISSbdYk0pOMDQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH v3 0/2] mm/damon/core: fix damon_call()/damos_walk() vs kdmond exit race
Date: Fri, 27 Mar 2026 15:57:24 -0700
Message-ID: <20260327225725.8591-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327142605.4834-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260327142605.4834-1-sj@kernel.org

- [RFC PATCH v3 1/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v3 2/2] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race deadlock
  - status: Pending
- [RFC PATCH v3 2/2] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race deadlock
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260327142605.4834-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
