Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B0390981;
	Tue,  6 Oct 2026 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269791; cv=none; b=QrdO7WYQvsMayjcI9hXju7hyc5gjemBaz4sIeCjG5i6o8yFmUg6VYt/m0APvVV5IBseoePjRG7grGjUlbjnumn4EgmsUYYLhHWH738STrLNPXGAqyS2TbKQCSfr0DqPEvY48nHJX/PigSB3Bm4RCiPA1jMAhl29T2+BOhVY9z3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269791; c=relaxed/simple;
	bh=Ng/dWJh619j5ROkBia49EougAtMoV2JjnAyB9sOYrXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWPIsODZmIoOSWIznjZeinZmv1AeQi++ZdX6l4vARTy100FC3osYhipKD7aH4DaKQFlR+l5wm1DMQripgjU9LmmGGd29L3IhnWTsICS4rE6ZnEnYADlYCgjyFv3Dvp7xEjAIIPqXmrjpd+QDugpq+xsozr3+oAIYua08WzNVQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0G2i9cq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0G2i9cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543511F000FF;
	Tue,  6 Oct 2026 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269790;
	bh=2TrSGIznF7im8gcegltGhb5pwVxJVzRbP+0GzODKKlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0G2i9cqB3NKuWApR6iaSzv6q9mWeKzdc63fIAyzU7olFj1n2Oi5rn8pAvPTfRSy/
	 7wI/+p35QAehJ9497fkMeU4VfutIk0IMj2REZ/mgM45ZNMdC12rbjQjyoBdJTnyK99
	 wDacEREJELrPGk+WNJiBPx2yil077Fzeuq7rspLT+Hs4b7RA5m0+kVk8oI3AutEMOL
	 /FXKiNDUgDOQi9gavHgJ9OgJ77FWoOtkXYwr5PENC4KxKmp/7MseQiMwd111e28A8v
	 Gj+fWIv7Bduj4120aFPafMbUb9qYvNo2RdiTJfv9WBu6mUDobPJ4BNIsiPbKLO3JK5
	 iwUJQFea/OCJA==
From: SJ Park <sj@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com
Subject: Re: [PATCH 2/3] Docs/admin-guide/mm/damon/lru_sort: Fix copy-paste mistakes
Date: Mon,  5 Oct 2026 23:56:24 -0700
Message-ID: <20261006065624.42053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006061549.627-3-adrianhuang0701@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  6 Oct 2026 14:15:48 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> The DAMON_LRU_SORT documentation mistakenly refers to DAMON_RECLAIM
> in a few places.
> 
> Fix these copy-paste mistakes to correctly refer to DAMON_LRU_SORT.

Good eyes, thank you!

> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
