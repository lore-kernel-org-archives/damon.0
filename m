Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897257;
	b=Z4VHbLq/HY8u6baMYiLTqIV7W8qQrX/xx0xwqEpK7FMH3ZP2Mhn76jZ284rjHv1O+Jiw
	 /FBIkI/GrSWFwjBK0FOnIQRPNzbBGotjHztkOj0wZdwQlwRTkfWgkIcl7BeUKnNYLDwny
	 N8QPl2IGJAhsDGWueS4NFdcvWI5UcuXog1TzzZcyOcCwoABnR9N5BOMSsfB9m8zgUeyPl
	 qtqyQ9oYfv6xVPhnFrzlGD4Fxo19BcB0HV236uTDeWPizyxufTJPe5qYVDlGfEdrJ19sG
	 RHEiRuFe66RMnjnuQs3L5ixERLr2dSKZ6d8NhlQOFQKrkDFCeBVbXuh8yJCKED5MP6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897257;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fawxIzGBOOv5fjnAp7ISjKaezIkrEJDCtQor36FftCE=;
	b=OOO4zkuZUQXk73hfGktEpY/fFt+W59XxXka13zdtnT+ko6yzpLuwnmmA0ReSzSTDROyl
	 96R9w/s/n9hM7AVKWRYJKj+ux+tSwv4lmMdbeYlQioSYoO0NzNjd85maL998O+z0yd2U2
	 aGcLqm6wVz8qVmfYTT/sqneyQ0VZYS53CVWjur4sqlW4QCwz4EcBz02rVYeBzpfO3cDFZ
	 6+RTHQtD4n94rsLcic08az4NwQkc8QlXhodsRUWDyG3FzQye9TpnHIo/FmStNSSX6qqik
	 uUfqMWiyM9ag6ZyB4x/14aBghUSBoEtjUlc4r98kR1WhaIJyZDR6MmidS7+/PZWnkyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7wFN+JC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78C606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7wFN+JC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF541F000C4;
	Tue, 17 Nov 2026 06:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794897256;
	bh=fawxIzGBOOv5fjnAp7ISjKaezIkrEJDCtQor36FftCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K7wFN+JCpKkf7N713hRu6sTmPKqaq0LUx7O/TtXAgJWn7DC87JG81Wix9GcfcRsk7
	 40uWG6sCiSWZrpXBUkZARLNXJK8ZggIQKSI5kDkCJp5vBsbOOc3SPzsecRxS4nULaY
	 z4Wv9gKO/sbDB47MyEzno/IC++6fp0g1pi6e8sAdpgIA8fO1JcHmZghX1L9E4dH+fl
	 iYT/PSvcSkPBuwhuf6obTUtC9gLdAeq6tj1tQtVbR9wKT+7UBaFsFq4Ej57CBTvU0h
	 O+f1wORHCj6L1jpPxYfD8xpiRvF91x1U7MeTWniKvloRPyU4KdhoHcOpspjr+P6TDu
	 cfob4KSfK/Rhw==
Message-ID: <sashiko-outbox-218259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/paddr: skip hugetlb folios as a whole in
 pageout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117-fix-damon-hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com>
References: <20261117-fix-damon-hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 06:34:15 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_pa_pageout() uses damon_get_folio(), which rejects hugetlb folios
> because they are not on the LRU.  The loop then advances by PAGE_SIZE and
> looks up every base page of a hugetlb folio that cannot be reclaimed.
>=20
> Use damon_get_monitor_folio() and skip a hugetlb folio as a whole by
> advancing to its end.  Do this before the filters, the accounting and the
> last_applied check, so that adjacent regions within the same hugetlb
> folio are not walked by base page either.  Test the LRU flag first to keep
> the hugetlb check off the path of ordinary LRU folios.
>=20
> In a pageout microbenchmark in an x86-64 KVM guest, traversal time
> dropped by about 99.7% for regions covering whole 2 MiB hugetlb folios.
> As a side note, there is a small overhead of about 1 ns per region when
> each region is a single 4 KiB page.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-fix-damon-=
hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com?part=3D1

