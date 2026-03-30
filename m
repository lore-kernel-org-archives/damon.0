Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC49126C02
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867408; cv=pass; b=k4dsNi2Kx4Kp0/xjQIlOp3GSXBK2OYisYl30hiJ1u0nMtcWqyMUU91QBpHiNa8RiqJnxn7baGZQsgpIXuCL1DuuTSYSyH+qFHsnAIBtFx3fE+w+bbigVxX1f4l81aEGdiF90KectqfmmnJ1SjDn3S3Iua5BljfY97X5UKDPKjmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867408; c=relaxed/simple;
	bh=0M2PvO2IGHSsGVFLO031ug2eNQ21UmBDdP6VF2BoU94=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YeAeSVArmI1XhlQMHnKi5OAlZecg10i6YoanaDXrG5xZGpny69tecdo6lwQMq4Wf/tu+rU5JSRwlI2AtTdgXUS7vXQZxAznnJMAtPbRHCEURb038x19G1fQy+bmpbonsfHSkjMwxWlBJp2oePQfHB5scAakPrUB3OIVGoVVvFwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=inyzmS2l; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="inyzmS2l"
ARC-Seal: i=1; a=rsa-sha256; t=1774867403; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jdzs1KElWh8NOTADADaQEBUj0tyCVnwTCfUey8i14MqN3RSdUPYe9imoWIs+OP/gApOHfXcLGzVBWiTvucHvZflw1EGBosLSK7qtuM0D2JFU1aldxa7u9uLxqvaY/A60ZnRoUHpDYMOfwIpRBzARyeedSGN0q2t7WxzqB7ZC8ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774867403; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0M2PvO2IGHSsGVFLO031ug2eNQ21UmBDdP6VF2BoU94=; 
	b=GcGfMgKjzxdJN/HaH4YW3wHu/Nef80RrazHFdWjLOTd0Yz38iPXJQckJKjTw+hlb9FQyJ0VYlhYDXCQx5Rv5D5HWVL2IZIUycQuJ54h7Lpveu40nS2mhIl+LWVKskNC8UgmsjQzCmdXcbKSCfkb1EuXeQ5P6x1MZ7E+vNfPg3Gk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774867403;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0M2PvO2IGHSsGVFLO031ug2eNQ21UmBDdP6VF2BoU94=;
	b=inyzmS2lM9XSxS9XwDaVqUzFPgpRp45pnGt6j6n9f0jYK/EpFch2OYuHRC6GI1CB
	vj3aXXNxgvSl4ueBSQJ4NhdmihryfmLFTAziY4asUAtrdeffQDjuTpGSbcfo/O4Ya+L
	Q5VdiplQxjz9oJDmL4ar60+rXgTOdw+TrbJHQ1EI=
Received: from mail.zoho.com by mx.zoho.eu
	with SMTP id 1774867402919224.40128047328892; Mon, 30 Mar 2026 12:43:22 +0200 (CEST)
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1774867400674237.14834366991977; Mon, 30 Mar 2026 12:43:20 +0200 (CEST)
Date: Mon, 30 Mar 2026 11:43:20 +0100
From: Herbert <objecting@objecting.org>
To: <david@kernel.org>
Cc: <krzk@kernel.org>, <ljs@kernel.org>, <hlcj1234567@gmail.com>,
	<sj@kernel.org>, <akpm@linux-foundation.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<kees@kernel.org>, <gregkh@linuxfoundation.org>,
	<brauner@kernel.org>
Message-ID: <19d3e5747e1.83b0f66f64051.6129386944586321569@objecting.org>
In-Reply-To: <6f045727-91ff-45ea-842b-c78ea61ae4d1@kernel.org>
References: <20260326072737.341964-1-objecting@objecting.org>
 <cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local>
 <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org>
 <ae7dc7de-966e-4e04-bb55-318d97c61909@lucifer.local>
 <a9f267d5-b0a3-4118-a1c2-5caa8a3b638d@kernel.org>
 <14366e29-4ee2-490e-8e4a-0c5cace1f313@lucifer.local>
 <04B79050-4353-4FD2-A596-1474BDB94B3F@objecting.org>
 <b263a722-e9b8-4a43-a075-46e4a753871d@kernel.org>
 <043CED5F-7014-4776-824E-07E027B7BDC3@objecting.org>
 <cea99016-5407-4392-9b7d-2e6a994f550f@lucifer.local>
 <E1A667AB-DCE4-4034-A36B-DAA458780A81@objecting.org>
 <e5d45f3c-4f46-40d1-bb7a-0a2f930fd7ae@kernel.org>
 <82256A72-42FD-475E-935C-629964FA80E7@objecting.org>
 <11429699-81b4-4c1e-b247-480136fd1faf@kernel.org>
 <6deb290e-b168-4de2-95f8-fc784ed31c27@kernel.org>
 <25688dbc-cd11-4137-bad4-a215198feee6@kernel.org>
 <19d3e3d3297.190bc89f62053.5899613485100180781@objecting.org> <6f045727-91ff-45ea-842b-c78ea61ae4d1@kernel.org>
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering
 module
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Normal
User-Agent: Zoho Mail
X-Mailer: Zoho Mail









---- On Mon, 30 Mar 2026 11:36:39 +0100 david@kernel.org wrote ----


> On 3/30/26 12:14, Herbert wrote:
> >
> >
> >
> >
> >
> >
> >
> >
> > ---- On Mon, 30 Mar 2026 09:16:44 +0100
> david@kernel.org[mailto:david@kernel.org] wrote ----
> >
> >
> >> On 3/30/26 09:50, Krzysztof Kozlowski wrote:
> >>>
> >>> Yeah, good luck. Several people asked for that already, like 10 or 20
> >>> times. Andrew asked that a few times.
> >>>
> >>> And yesterday we got another sloppy posting, so that would be it for
> >>> having some time off to learn things and take slowly. 3 days after th=
is
> >>> AI slop which does not even build.
> >>
> >> Bot confirmed, I guess :)
> >> --
> >> Cheers,
> >>
> >> David
> >
> >
> >
> >
> >
> >
> >
> >
> > ? That was me learning the ropes, by making a patch to the QCOM subsyst=
em
> >
> >
> > and it was a genuinely "ok" patch.
> >
> >
> > May you please tell me what I did wrong here.
> I thought you wanted to "take a couple months break"? And I suggested
> getting a mentor first.

Yeah, that again, was a bit stupid of me, but sorry for breaking my break, =
but I wanted to try doing a human patch, to see if I am capable=C2=A0




> Anyhow, this mail was sent from "Herbert", which is quite ... confusing.

=C2=A0
Changed, it was a display name for some reason.


=C2=A0=C2=A0
> --
> Cheers,
>
> David

