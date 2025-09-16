Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414291C5F23;
	Tue, 16 Sep 2025 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991904; cv=none; b=K0N7e3k6BWR9tC2XN2+dgC6tWPT1ftzpnq1ZSP777Da/JhIyOkGgbiTPVqQ/nDWAn2dIuu33qiCnn9WinDF+CeAVBkBYqeioDWm/fIOu5T9Nmv2/wpKCbubnktWWgIVOo/EfBdMHMalC9Sbr49bSbiTg4x/IQQSA+e3IoIq/eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991904; c=relaxed/simple;
	bh=CDq+k6WKAKWCHXOa21JcbnmXe7JqkortJRjx4/7bAYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDcs8Mr74Onu58TaCXpxeA0Cd+zGn4WbqVXfqIjXrPyr+eCMX9ns4+DkRZpLM3eQC7eMzieCes0JCvjZ+YWanv6UWi2yJdsVvw0P3sTttXIpcIZotbUkjUcUQ3xpgw3ssF2aaDemiqMY/eEGYfOjEXRU8/qjavdMFVuVPfuMGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0dr5Bsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0dr5Bsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D09C4CEF1;
	Tue, 16 Sep 2025 03:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757991902;
	bh=CDq+k6WKAKWCHXOa21JcbnmXe7JqkortJRjx4/7bAYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0dr5Bsf6F7wID+23pMS3qtrjYQw7SfnZQl42LtDNmJjlMGb5mGUg3pF7UTmUErLa
	 pvSPR7oOrAgp/ho4rJY3oAmhfK0QuPba7c+3LqxfKRlRUoaF/1NsvAqUYxKL5Csbcf
	 JmuztPVwKoYy3DK6f3XKugtJzs6hxResL+XMVZRP5wqWYsAp4+1ZRFTXNdcLs6uzyL
	 Glt6kWD5BSDU39XQlyzK5EYGlOdQtGNDLoOczZEIpX0nhxjOgimEQNJy+Z6ySbHEJ+
	 XwAHYd6Qx71N77KQAQV7IQnzHEKLRXQcHpzGIWF/u++CjCQgZGJQFSrMmD72W/RZWm
	 mIqJDPyzd7/mw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/6] mm/damon/lru_sort: use param_ctx correctly
Date: Mon, 15 Sep 2025 20:04:59 -0700
Message-Id: <20250916030459.114166-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915184306.110418-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 11:43:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 15 Sep 2025 08:05:47 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > On Sun, 14 Sep 2025 18:58:04 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > damon_lru_sort_apply_parameters() allocates a new DAMON context, stages
> > > user-specified DAMON parameters on it, and commits to running DAMON
> > > context at once, using damon_commit_ctx().  The code is, however,
> > > directly updating the monitoring attributes of the running context. This
> > > doesn't cause a real user problem but apparently this is an
> > > unintentional mistake that can cause code review confusions and future
> > > real problems.  Fix the wrong use of the parameter context.
[...]
> > So in particular, the global ctx will never have the correct attrs pre-patch,
> > since it will always be rewritten by param_ctx, which never had its attrs
> > initialized.
[...]
And it measn the monitoring attributes prameters of DAMON_LRU_SORT are not
working at all.  I think this deserves to be a hotfix.  I will send v2 of this
separately, cc-ing stable@.


Thanks,
SJ

[...]
