Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D681E7C18;
	Tue, 14 Jul 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038299; cv=none; b=k01n9SA3MRM8w/pyqbL6TG3+o3dM2C2x1nDmlrMZveioX4CPinhimQZpr4ur7d1hTqfsE1VhBD4W6/woJfUpJ/dI/sSqyYWZqcmt4ouv/EdnRC///uefKKMlhgHqav0AjOK9jE3d5s2L9vlT7Q2TBFRRfIdUSQRA3bLKedq7BYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038299; c=relaxed/simple;
	bh=B/zmmBNm8lQqUn2+NBE0/Oy8aOKR1x4reKQwpotHxvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/USQQxPD6Wj9mpcfJkyQlFykQeWp2QpoM3i2KKOn8B10GLTz1oSrmSgaWyAakIVed/HzCmR+JWPVAl8Bkrz5VDFsqnpqFcANF40/iDos19XF19WCeD3MI/Bp4/c5gE+dZHtTJxN2RxmY+HvEoN3UdXnbFwlp3cY7b6vaqgyc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PytcVd8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PytcVd8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592CD1F000E9;
	Tue, 14 Jul 2026 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784038298;
	bh=B6UDn/zB13GY2rQ9/2v1cLrwdrHaWMbAjwv9EdpOgA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PytcVd8BQgI/38oDRG2qlhYVQChh7MTMHM2uHfiV55lxVh25JhDX58hRVcmGZdaQ9
	 ZF5qI1aOuiwO1j6IoftP1UaIhfZ7WIhHztUvP7Ozm4R6H6noWdZBWTj9zoG/5JZWao
	 Ti+s7PkLFiwAiF9dJR5dm0BWXB9saA63zVcU7O42DmM2MpW6RwUubX0AIV3TaA6lY2
	 meIfQFGHbn8KN//6bmEJioh2Jrv6PFi361ZAxrm4OhJwUTDKS/QBG+/ZEfWT1BkeKG
	 X242vnAKZmjr2HCGBL6IOFhWqXTxtQo/NOHU224G+3IV3nJGAuNkLD+uMkHZVhtapW
	 8A5XeIAPCr2AQ==
From: SJ Park <sj@kernel.org>
To: Xuewen Wang <wangxuewen@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon: remove trailing semicolons after function definitions
Date: Tue, 14 Jul 2026 07:11:27 -0700
Message-ID: <20260714141129.96609-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714075358.1592393-1-wangxuewen@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 15:53:58 +0800 Xuewen Wang <wangxuewen@kylinos.cn> wrote:

> Three function definitions terminate with '};' instead of '}',
> which is unnecessary and inconsistent with kernel coding style:
> 
> - damon_pa_initcall() in paddr.c
> - damon_va_initcall() in vaddr.c
> - damos_get_some_mem_psi_total() in core.c
> 
> No functional change intended.

Nice catch!  Thank you for this patch!

> 
> Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This series is applied to damon/next [1] tree.  If this series is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
