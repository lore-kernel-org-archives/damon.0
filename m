Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB52C11FA;
	Wed, 11 Feb 2026 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786452; cv=none; b=RA7ndrFlAJEAvptoxMF2XHQugTNsb/A2L3IhVVJLFefSaQ9gu+fuwfzLJ5l7dz3FPVwSOLQizHav4pE6xtz7unt1gzpHhMNYvEhQhUWT+T8yu3UvGMKHqB2/CIyq26AQ7JeoTyEZvddP9C06QMUGLn2v7jWXkQjEWm+3NYueV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786452; c=relaxed/simple;
	bh=UTpjsZww6YPPiWFz55VMFdksp+RP1wddMHWtM/ylmIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLxFFng+i7+LSb8lJXu5Ncn4TrDYQQJTG0VAXuZJ8787fk9bg2td36JhPadkt+vcGPYdHmKhPjUOujFCXKuh9zBKWxT46tVXn8bG8G2075oNd+1R6ExzWWyXTqqZ5heOwdKQsIhWY70nEHEd6p9lxNPEUHlhkbKsaOYw0K6w6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt4r16Bz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt4r16Bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7713DC4CEF7;
	Wed, 11 Feb 2026 05:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770786451;
	bh=UTpjsZww6YPPiWFz55VMFdksp+RP1wddMHWtM/ylmIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yt4r16BzYI4WeotGZ0dx3l13TAzZEJ7pDFFXMu0AraLYNQiFZTqgnyClgwHC6VAE4
	 m9wCXzt8mqsrCWV6v9XxCcQQKZEdNj3xYxOXX+E7P8IiJ6rUWAnsoJJ6pu8J2Xw/f7
	 Cj9giHjT3BwMx7ngk+oJLDxYVWpPr2cI69sDAU5qdSvL2aaP9A19J4apIyhCx+gngp
	 pPjfLr/8THLNbPIrmbRCoj9ydHZYAIf9+bUugyIiblY3Fv5bA6MGkbvRPnz+7QgA1l
	 U1FnOUvC5jDQ9YKZF1aB0XJb4iNIVIAK3a+pGY9wE+5Orwzsiu5I57/etCCabfuaKr
	 f8RK5y/zFN8wQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Data Access-aware Transparent Hugepages
Date: Tue, 10 Feb 2026 21:07:28 -0800
Message-ID: <20260211050729.69719-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211044533.69515-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Feb 2026 20:45:33 -0800 SeongJae Park <sj@kernel.org> wrote:

> Forgot Cc-ing damon@ and linux-kernel@.  Adding those.  Sorry for noise.

And lsf-pc@ ...

> 
> On Tue, 10 Feb 2026 18:28:55 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > Transparent Huge Pages (THP) could be more efficient if those are used only for
> > frequently accessed data.  DAMON is one of the ways for fidning such hot data,
> > and hence there were interests in utilizing DAMON for access-aware THP.  A
> > simple experiment leveraging MADV_[NO]HUGEPAGE based on DAMON-identifed hot and
> > cold memory regions was conducted as a proof of the concept.  The experiment
> > demonstrated [1] an 80% reduction in memory overhead while retaining 46% of THP
> > performance gains.
> > 
> > Multiple discussions for further developing production level access-aware THP
> > solutions have followed.  Most of the discussions were made in private, though
> > Asier recently proposed yet another approach [2] on the mailing list.  As a
> > result, we collected interesting challenges and ideas for the production level
> > data access-aware THP.  Some of the ideas are not yet public, could be
> > controversial, and missing important things that more eyeballs can find.  I
> > want to discuss those in LSF/MM/BPF to get more ideas and make high level
> > community alignments for next steps.
> > 
> > [1] https://assets.amazon.science/b7/2b/ce53222247739b174f2b54498d1a/daos-data-access-aware-operating-system.pdf
> > [2] https://lore.kernel.org/20260202145650.1795854-1-gutierrez.asier@huawei-partners.com
> > 
> > 
> > Thanks,
> > SJ
> > 
> 
> Sent using hkml (https://github.com/sjp38/hackermail)

Sent using hkml (https://github.com/sjp38/hackermail)
