Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B336D4FC;
	Tue, 15 Sep 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484317; cv=none; b=BvxxykdLVtRVWxBygxffFuKwGqkWHj4Dnl1IqQpSsWNjb1COz+igBgEu5f0Fsh/wCXWRqTczfjDixOPNpzzgMgrGL4edQOGvr/SEJTT3Krguu7FE7sXgWmVbAlxUYjfKT+L2maIVehNIukjeyycd5pCnGBjcqxr83rAQg99vupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484317; c=relaxed/simple;
	bh=b9XjXyy0thk9HLrHobEvjUHNk1WDu+cgL2O5XtdFzWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTzcAEfnd27bl3dB+ioXOtyhWU5J/vZowhjkF+TcrOukKw/Q8hBVlapJNVfc/u8zww8bJCYsOBXpzi023pySpWqZukFVQp1JhKfR6WhTLZFhuQjQqA+W7kLT41qHEOaQhXynHwveltws2hooMaL99T6zzavZrzruAFFCXM+QUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHfmlG5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHfmlG5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180CB1F000FF;
	Tue, 15 Sep 2026 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484311;
	bh=JTN8lMc50PscJwhdMYkWxf6DIrkJ3RqvGR5lgJYuR9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHfmlG5Fu0AY30+2hg8Ux4vA66SpyMTPZnBgbGv9qMTPxneg9BYhXRyg1thvljVKx
	 1ycbjf1gqqCz+CbLqlhC3IL19bBwYHsn1HxBeYFMIlV6GbZJdTg5wbsCPGOtj/iixI
	 vSqCilDfIhpEaLEAyy83YnRU2Sk7FoNUX86pCQPaYhYemLdGRjDhpk0U4CP2sGA5aQ
	 ASLSl8eslkmyau+KEtZ9KfmMUUPdokRIhHQO+amkGCBq2gFc8Ye77sP0PGQSa2ybP1
	 wNEb8ZRBQI1iWgCoeKQ04bRiDBH2+IsPUaPICk/HZHTCs8S4P+cHRLw/tH/qgfDaVi
	 y9kECvbDj6qeQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: introduce hugepage_size probe filter
Date: Tue, 15 Sep 2026 07:58:22 -0700
Message-ID: <20260915145823.92329-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 07:33:49 -0700 SJ Park <sj@kernel.org> wrote:

> Knowing whether a given memory is backed by a hugepage of specific size
> is useful for efficient utilization of hugepages.  For easy monitoring
> of the information, introduce a new data attribute probe filter type,
> hugepage_size.  It works similar to the DAMOS filter of the same name.
> It works for memory that is backed by a hugepage of a given size range.

Sashiko found no blocker for this series other than a grammartical error in a
document of patch 7.  It is too trivial to respin the series in my opinion.
Andrew, could you please fix it together when you pick this, or let me know if
you have a different opinion?

Sashiko send its findings to damon@ mailing list [1], and I reply those if
anything needs to be clarified.  Please refer to those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
