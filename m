Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DA3093B2
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225168; cv=none; b=AAKIAEm+8NCEU790Y6lK39LfH2Glrzm8G6h1B0lrTnlBKLZFj0A7iOThlIbl4QC1KGjJBPL7w2GBTnVWjrBQHVYoACOhu4i8xIQgseNByiTpdbJEQwAYOrL61pUMHSPyC0ozjHb27KTbwmOvTHFaT9wYUeTG2w5lUq15Rt2mNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225168; c=relaxed/simple;
	bh=ZQ69nE6BeRTP9U9zxzKQoeXDbMPg2+HM+sWjHvRdEQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJJqaHCpcJYajuFwe6WIAjqzqPVpSrvyrrqd4OsH0DAhX7CPHjl+zTYxuPT72FtDhQ6S0xvSH+iKusaD1DxeUq86B29HaKHcEklMYnjwAXbUDDhvJbHKvAKz2cXJr/xR/nldBegQ3z6Y0g8BaWyCZBULcgtoa7uDKXhOJcWe+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bumVk37V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bumVk37V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244BBC4CEF7;
	Fri,  3 Apr 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775225168;
	bh=ZQ69nE6BeRTP9U9zxzKQoeXDbMPg2+HM+sWjHvRdEQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bumVk37Vqdypmr+L6UCT9gZW9o+jaDTaVgnrBh3EGyv1VEnGUkB9PZ+XCfFtbSBJv
	 6lS4kXpukMf0e+QjHCzKXTxZzJ6cUa8QTwpUtM1ZEHK575MplGSKOEH9hqFfiOxMD5
	 fG64Uq7L/BTNaNnHr9xPTHCe08Hzo25liFq/YbJsW/A67hQ6x2Yss8GMtSVaJGtPYp
	 DMJ/G1uKeteLCQUnRIXn/nnN6dyp6t4jB3fY5ao5dSdYqqTKgKBX/E+FLUPYmFP+HO
	 MZNPGSxT2bC9uAOe9B4y9Ozi2X0lDa5zetWhMADbp/XWeQt6FexzNw+ePydKDIbEmq
	 MsraxYYaqvx2A==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Fri,  3 Apr 2026 07:06:06 -0700
Message-ID: <20260403140606.50524-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403043448.53045-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  3 Apr 2026 12:34:48 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Thu,  2 Apr 2026 06:54:39 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Thu,  2 Apr 2026 13:34:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > > - When the user writes 'Y' to 'enabled', if enabled is already 'Y' but
> > >   kdamond is terminated, we treat this as a restart request.
> > 
> > This sounds bit odd to me.  User shows enabled=Y and kdamond_pid!=-1.  Why they
> > would write 'Y' again?  Yes, they would notice kdamond is terminated in real,
> > using 'ps' like tool.  But even in the case, I'd imagine users would write N to
> > enabled first, and then write Y to enabled.  In other words, this could improve
> > the user experience, but seems not really necessary to me, at least as a
> > hotfix.  What do you think?
> 
> I see your point. I wasn't thinking of this as a hotfix at first, but
> you're right - for a bug like this, simple and backportable is the way
> to go.
> 
> So I will drop the "Write Y to Restart" logic in the next version. I
> will only fix the state in the 'N' path and after commit failures.

Thank you for accepting my suggestion.

> 
> > 
> > > 
> > > This way, even if kdamond terminates unexpectedly, the next user
> > > interaction will recover the state automatically.
> > > 
> > > Does this approach sound reasonable?
> > 
> > Yes, the plan for the next version sounds good to me.
> 
> Great! Thank you for helping me scope this properly! :>

You're welcome :)


Thanks,
SJ

[...]
