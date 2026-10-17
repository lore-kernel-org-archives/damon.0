Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F60355F49;
	Sat, 17 Oct 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253595; cv=none; b=Vuku63iML2di6oNwyzkG8Fk+BNd2daAmIi+TCVhmH3jYqk5szFthyhfs6W+NDBpdJl9lDLjpqcCSk68p4ijgL9qLNy1rWiWUJl45F+4ab6UF4FdngIDtIWaXh9rhyINrkr1qhfUrbj9MfJflV2/8O24yfTj6u/Zv+oGH0tRAfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253595; c=relaxed/simple;
	bh=YJoNu6yU/YdhRjfSzO8YpnSv9Tm0EvsOs+x3mmFcpfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsR4Frm6cEFnEfxfGpbUYwb2B3dkh5ArN0czchVViCEnEhsSEM+CqO0zEjy/TTWkseE6D+HfPOrB0Dw9jvwHwCsiy3w4sGsVIS9TimEq1ZfyZzzQfWhsTNkoNj5sOZzF7ugoXpvilMpOvXGkhQDgdY6du3L+bIjxf0I/xc57Pxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La6ZcW/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La6ZcW/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAAD1F000C4;
	Sat, 17 Oct 2026 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792253591;
	bh=rxnIxgjhHPOhNba69hG5CN7WDYZeGiFPLDt2bgf14ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=La6ZcW/Uhu8NVTIoeLjexdfAzN4hdC8y+79OaFNQ38HYguBGwUNMaDBCNLwg5hAUz
	 JsEjETx5AaTp5HY5lntp8yJ01siNMTUqyr4NiDjXw1/ft5x1MYooNWihv9BqmkGxf6
	 WX6Y94NstW4bOMsxeJuDyHPUFDX7ex94SishA2sP/6ZMSjEgLGvQqZnLmbgaes2fCe
	 CVQECjwZ1Qj/fNYoVxgq2XgHQHfM21Cn8NUMPx3+xxLH1Pns2d5QXnvm4H9s+2+oGV
	 tuc5FAxYGAkVjFUiDw52ylUbR5EkDWD19/9DqggngB8Ih1Ryo+PrV4Sg/WbpTbnbtU
	 WSuU5it07fMlw==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye
Date: Sat, 17 Oct 2026 09:13:03 -0700
Message-ID: <20261017161304.103620-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017083535.1261388-2-manuelebnerli@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 Oct 2026 10:35:34 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Fix tenses. Split long sentences thereby imporove readability.  Replace
> 'set as' with 'set to'. Replace [] with () to make the file uniform.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> ---
> SJ, could you please replace 38b3709936fa ([v2] 'mm/damon/lru_sort: fix
> grammar and stlye') with this patch? I messed up the path in the subject line.

Thank you for fixup.  Done.


Thanks,
SJ

[...]
