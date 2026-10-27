Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062164;
	b=pUeERkUUbM+PhaMYjhTjf4A6Gb+7UEYQnSR+iVObpIoPvcyixPLQxC6liVOihJlYLSKA
	 pcqNmB5XBvTEke0BrYal2gFVjTrLq/xdxPuR3Vgc+uAIgMcrCtZikfqwnUfJnCkyNSHL9
	 H2/BO1vsxj5M3Jy7wnvWbijJrE9GAwQYShPnFDpn/RwjNvAyX2hPIETJTndRbm5jqKlkF
	 TRQoMxdJBfiiMuwy7TXQaT+m3OqbOH+dt/fZH/XLs2NOXFeidgKegvpJL/ecPBfYSPoP0
	 ln31jwB5V5eTSZQThpxmz/fE6Eg2ALtMFo1CrRHsOkp8rcui/JOhmt3xOU50BXHTlYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062164;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7/kZUclGYQP8NN34Z8XfBgy8oKvHfBFdfanXD9OlfAM=;
	b=ptTYF8md8ukhdZNIukL0utOi6W4EMj2WDV42ruJGHANnJsUi0WwGN7a3ZTMdqkj8FQ43
	 xUFRmwRS6ZQ3jlVzSFf8lIh2YQKw4pyL0yTI7t1qRWIZgQPGk9OTGSF4p5Eof+2a/Qkyo
	 ispM6mBvJBHkWBSkxeRPUq4w7agWmKU6cITZQZvJ1N4Lu8qqdOo41nMyAy81TvfzOth4v
	 clCKRCvSnYPQwewVDL5ypkkMZ/OG7kwOp/gjPjcTEqgmaKEATak/B+bbvaXYonLZp+z5t
	 0sithd1WixF+pf0ib3pdRRsSoqkWPaubSzqt/8wOolY3cFN8ETEG2f0T6gnYKtq5GTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhwJd0HH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25172606A31A;
	Tue, 27 Oct 2026 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IhwJd0HH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533701F01825;
	Tue, 27 Oct 2026 00:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793062163;
	bh=7/kZUclGYQP8NN34Z8XfBgy8oKvHfBFdfanXD9OlfAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IhwJd0HH7ml97hUAhy4mM+LxrQ2bHSAnxXT5bcTTqCYrKorbjVOfa6aQK448DPZUZ
	 I0UbDVCSy2hHLW5PW4h032ayX/+bDm61VYux5U+fOZd7u5iOR44XnnAQq0KNDlAhUq
	 jHUdbLzFXl4HCeqTogfS6QXU4nSqG7WsHqALzTeQcaDypFzXJjdhjSDGSpkntipz4i
	 UI97FyUNZraeWVxoio6pYIeHastvNhvR7snqnMmzqVCnUvGEO0vnbj6cr3GER0BFD4
	 n1EoM7UhMef2S2pPI2Qw/maUpE2zwjOXsiIqMNgYEkNmbL8RdxlO3rp/V4bemheEIM
	 r0fMOuo2qCurg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Docs: damon: fix grammar and typos
Date: Mon, 26 Oct 2026 17:49:15 -0700
Message-ID: <20261027004916.160854-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Aveline,

On Mon, 26 Oct 2026 22:14:32 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> I was reading the DAMON docs and kept running into small grammar
> mistakes and typos, so here is a series that tries to clean them up.
> There is one patch per document, and nothing beyond grammar was
> changed :)
> 
> Some fixes pushed lines over 80 columns, so those paragraphs are
> rewrapped.  Patch 4 picks up what I think was left in lru_sort.rst
> after Manuel's recent fix.

Thank you for these fixes.  All look good to me.

I applied  this series to damon/next [1] tree, together with Manuel's
suggestion patches.  Manuel's suggestion patches will be squashed into your
original patches while adding 'Suggested-by:' tag for Manuel.  I will repost
the resulting version after next -rc1 to request merging of it into the mm.git.
So, no action from your side is needed for now.  If anything is wrong or the
plan doesn't work for you, please feel free to let me know.

> 
> Based on damon/next at 9d301805e3f6.

Thank you for clarifying the baseline.  I guess this was because your patch
depend on Manuel's early lru_sort.rst fix?  Clarifying the dependencies would
also be helpful from the next time.

By the way, I found your patches don't have the usual git version signature.
That helped me finding a bug in hkml.  I fixed the bug, so no problem.

Nonetheless, I'm just curious.  I might be able to make DAMON development
process more easy for contributors if I better understand contributors' work
setup.  Are you intentionally removing those suffix, using 'git format-patch
--no-signature' like feature?  If so, any reason to do so?  This might just
don't matter, though.  Please feel free to do not answer if you find no worthy
to answer or just feel uncomfortable.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
