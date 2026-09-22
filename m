Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC96576EAA;
	Tue, 22 Sep 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097693; cv=none; b=lTAUwVNN/wZ7Tjvxuh4RIoN1gpF1lL8TGEyzWB4N5fsD4MARCScu5Li/CMqWq/MVGZyJgARYpRT5g+SxnhqfRrNAtm+SJh0sdDXG7p7fs+AAGpNdfs/wU4KlWhYKgb7VUpz/5SHrSM01ysX3Ypz54q1sQafqhZoDLnFhB6OOd08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097693; c=relaxed/simple;
	bh=lw3XClRq6WFmNlpAnSS5DAExCQJRDFkeL23ahHR58Ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rbJkKQCQ4IhDtBlOzQnMFnM/UDcMUhh2c/K9l01Hc1V3PO/FDZ9susz/1igas1qZSpXrMctELfPfPfbZ4ngBJfsrnlBr/8Ebhfey4jDjuP4KBc3niPh8PQcWlrzEDk/aCBZ9RHfEcfCNR/dCWpfTNeph4BYW99hAY1W4Pa0bbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0Oc6+cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0Oc6+cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615D91F000FF;
	Tue, 22 Sep 2026 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097691;
	bh=lw3XClRq6WFmNlpAnSS5DAExCQJRDFkeL23ahHR58Ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0Oc6+cmMC1R5seBXuRm0ebYP86unZ78J4LPVCbmcxDSH0bnukjRRk2VgZB4Uc8WC
	 PO75uXi+0N/bu2oXV3jE9c+cKKfhjpE73MRxnO2GiqxPsFLb14yzEsHOCtnEZ8R9Fw
	 ub14XxDSGwOkGPRQbRG/DbXX28OUrwG32PvbwIf/TCdQwomQZcUCY96qlgQdGKcYa4
	 6CLos8xD25M+CD+yG1mTQvObFNwE1/7p0VFQeC/KoZX4+8An6tZYefNOwQoS6QIJv+
	 GmbGTErGP4oCkmidolVG19lOK3D4Fo/LUbpHw5jnQrtfSTzHVVEUzpPL6fD5KoKFsb
	 fWkomTk6tiyeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] mm/kasan: use hw_pte_t for the early shadow PTE
 table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-7-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-7-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:21:30 +0000
Message-Id: <20260922172131.615D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> kasan_early_shadow_pte is a complete PTE table rather than a software
> PTE value. Declare and define its elements as hw_pte_t so the object uses
> the PTE table storage type.
>=20
> Read the first element through ptep_get(), which returns the software PTE
> value expected by note_page_pte(), instead of accessing hw_pte_t storage
> directly. This also uses the accessor selected by the architecture.
>=20
> No architecture selects ARCH_HAS_HW_PTE_T at this point, so the storage
> representation remains unchanged.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D7

