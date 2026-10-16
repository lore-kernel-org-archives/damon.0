Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F84DA528;
	Fri, 16 Oct 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108815; cv=none; b=fhdLfRIKwLww77f4wCmvG4bsISjmBGjRD8egRlRH/aBgr6VWHFKfCyEuOT1IAMgwPWNbId3VnR/Eh/9GCQSX5RpgDcWKeEs4Iqmsug3K6cmeFk+BtVXKUyN6Kn7LJzlgSwnuod/0pB9GcNg6XWqqX3KyW0jVKPjE69pnrGlGr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108815; c=relaxed/simple;
	bh=Kx5vgbZhrrO1QHu1WnmIiRxzsnTcmJloYHpdEt8PN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1Z5zBVjXzi6N737YYRhTatLzKcj0pQDkd3v4i+bDxxfrkg12VMT0qApUmgRrmfJoD30xdF6brzSdDtUsneF5hZtl/Fz/aiVkVQzLqRgHKZG4y8dtFsVc440r7aYYSmqZnugyRG34FZjinyc/EsEqQSbwFmfE8JUZA+msJST35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQLV5NhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQLV5NhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC51F000C5;
	Fri, 16 Oct 2026 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792108814;
	bh=uxYyInMrHnqPkah88WKwwT/87RgbFDAoJpgskmZyYkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQLV5NhHAXTYNg7fDwLNWKJrpd0kg5Ngwn4DyEuKGMScurqHk2xDIoChC6xIsmgm4
	 05b2wbwwR76Z4w5NgwDHiJSmrfpZaX1LuzXxrHzTIQxpr1LufBMxi077Sx6Ph1k+VI
	 m6CfSIZyV0siHZAcNa/zEkGIJ8/ecCXUJB4tnOCoQ2KbwJrVHiSPNEAXiprZjE2aha
	 sV09C15br4Ph75W5LL4QhCfe9hjSIEbe2OK8RLkvVygPvnYxL5NgHUdDswD3Tb1a9y
	 Bh/uAiHmlR68i/ERQz5YTzhYpZFzDLQHo6f848u65OsR0h44PTNbb+OxYOIrzMbbsP
	 qr3yGN5w49Lkw==
From: SJ Park <sj@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: exclude DAMON docs from MEMORY MANAGEMENT - MISC
Date: Thu, 15 Oct 2026 17:00:06 -0700
Message-ID: <20261016000006.113338-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015-maint-mm-core-x-doc-damon-v1-1-226decb5cd0d@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 18:31:46 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> MEMORY MANAGEMENT - MISC is a list of misc mm sources and also acts as
> catch-all for the mm Documentation subdirectories. Documentation for
> DAMON is well maintained within its own subsystem and also actively
> updated, so there's no need to Cc all MISC maintainers for them as well.
> Thus add exclusion entries for them.

Makes sense and sounds right to me.  I was also feeling maybe I'm Cc-ing too
many people and considering doing this.  Thank you for this patch, Vlastimil.

> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: SJ Park <sj@kernel.org>

> ---
> I'd love to have the time to check the DAMON documentation changes, but
> it's simply not happening, so this will save some mail traffic for me,
> if others agree.

DAMON release newsletter [1] could be a lighter weight alternative :)

[1] https://lore.kernel.org/all/20260830235014.64406-1-sj@kernel.org/


Thanks,
SJ

[...]
