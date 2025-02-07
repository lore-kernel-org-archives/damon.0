Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC61A3151
	for <damon@lists.linux.dev>; Fri,  7 Feb 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954336; cv=none; b=gHif5be4dnXjBmM/XGAxC9U7f3DErSeIyHnNsQXw2F/FG8ZITULh01TuVBGah1q1n6WgKMUWdhHEanZMfw2Othot38TOospYS+2MVzrMZ0I9VrNS9GfYaK8j+mA+4n6RwhnSn++FOHWY6wUxFvcJ5yqMhtMu2pgSr3O/kuHoJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954336; c=relaxed/simple;
	bh=BFWvHtCqI4zHx0zSd21fwnlKrln4GSc/JnQ/Pky/4EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZ8MP2dy/yuL151vT7pISW5w5xaAmUlTSeCvcFXmje1jQ+am++TlwnsCsBA3ZSCmYiikVpUmG7DD0ZYRkAm+QCjGQU1rZm0vwu+SSMAf3tvxjC02pSzt7w0LKA8ntGhcjUdN9/ougvrraNAF7nLXFsgsZxmjRitGBTAhxxqbUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQpF3WUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQpF3WUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2431C4CEF7;
	Fri,  7 Feb 2025 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738954335;
	bh=BFWvHtCqI4zHx0zSd21fwnlKrln4GSc/JnQ/Pky/4EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQpF3WUqxEgU+XzXEz5sFp7DqVylKk1Bi0ADaBuUG6nV3iZmlG7y7Q20/yr+lHnMW
	 N20d0uDA+BLXHRqq7SlSUYNiOQhJGxqydRTHVB0YATT6WKdqTpNTocXHQTLPrszZ+N
	 moFNkQcnif3chxG99RQkJbSBaWxrl4UpwN0pB3aNBY3xXazcs9EyZNf2N3cz9nuIhn
	 wDdsV+Nbx+T7B5QnZUHZYNhQil95R7eoGoPBRJH+iOLabnKeOMnzXXJE8nIszbsTco
	 QbkXNkcv/fa21fZ2Y1nUXa7vZTbfNgCbB9YvWvTM0VhXXcIZ8gqNRfqVY/UOR7N5Qf
	 OWr4X+KkX8oOQ==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 4/6] mm/damon: introduce DAMOS filter type hugepage
Date: Fri,  7 Feb 2025 10:52:13 -0800
Message-Id: <20250207185213.43553-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cea1e84c-70da-4bb1-a35c-f7d0fc8d0ee6@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 7 Feb 2025 18:22:04 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 04/02/2025 23:12, SeongJae Park wrote:
> > On Mon,  3 Feb 2025 22:55:31 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> > 
> > 
> >> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
> >> +		folio_sz = folio_size(folio);
> >> +		matched = filter->folio_size.min <= folio_sz && folio_sz <= filter->folio_size.max;
> > 
> > We should also return 'false' if the folio is not a large folio (folio_sz ==
> > PAGE_SIZE), if we agreed to my suggestion on the previous version of this patch
> > series?
> > 
> 
> Thanks SJ for the reviews.

The pleasure is mine!

> 
> I will address all of the changes in the next revision.

Looking forward to :)

> The only thing over here is, I would
> like the filter to work for folios of all sizes, even PAGE_SIZE. It would give us a more convenient
> way of knowing if hot regions are mainly being backed by 4K pages, and improve observability.
> Let me know if thats ok?

I have no strong opinion here.  Unless others have concerns, I'm ok with your
approach.


Thanks,
SJ
