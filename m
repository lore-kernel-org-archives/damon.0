Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA73BE164
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865699; cv=pass; b=UODTw7P23AdAlx2tDdOwnMrB22Q5u4Q8qFBA/SN17TXXfTrLcGbkKntK78a3F7tDbvNoxA6UolkWTNKxtNKVRuJhfQsog1kRjrTPCPro9Kp7OCTVrqSRfklXz2zwz5uoTbIF2P0ae2wZVjUVNiGuY0notuVvulIW/jTEti0ZPZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865699; c=relaxed/simple;
	bh=VFMJ46N9qMdCvcsjoGJqP/bweEV5DGEGreIBFziMe8k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j0KIGGC6DT6y55DxIoDRxJglO6jBQZPX5VlgrrMJwUlg8NSTcbUEIA8OjlNf3rKPPE/w6t8OzJYbd73ZNN4vVN1ws+EtxRlzknFp1/ByY59jmauK/g4diwaM1oI6cFHAZyTbNqSeKU85H+qZv7YMJ4XqiCICAxOBGCxdC3eu9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=LbTb25hB; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="LbTb25hB"
ARC-Seal: i=1; a=rsa-sha256; t=1774865691; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BqBNPlsbzpkZ+nAmQue2nRCOWhYiEPqo7AWEzt5CvcaDmEdA9uNaeqyrNf4VU+o3WJ7+BwKWB8wiKPSqhKtfwEHXxupP0qJGmSm84MYPq3cd5E5EFL5yLtQ29/H0odCUL7T4IsIm8lGnMShijCzH8s9Ae8xXqi1Sxhf8CyMg6kE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774865691; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VFMJ46N9qMdCvcsjoGJqP/bweEV5DGEGreIBFziMe8k=; 
	b=CV2gAapZAm2PUzu9fJF5VwFJi6zo2YJcBvN/sNok7fvgYxoHzszCVXqMnfrP7V6Z5WlfoR2/VDzRX0s9Bkg5uLXxQ8QhkQ11JsKu6BpUXi1h+D0+aJ62lI4mJrXGA41x6sX+8lvp+J+p7ASK3WsDRdZhWmnkl+WasP+cc2Bah5I=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774865691;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VFMJ46N9qMdCvcsjoGJqP/bweEV5DGEGreIBFziMe8k=;
	b=LbTb25hBZBzpC8Z5NKK0i433O5MjyarWBNGLh7xmSmMPfdrIlbw8fKdN+RJ1G+dM
	W6veJs4XGnVfxhWAnjyPbdpqmsn8CQ52Qhx3RYDHcNF2v0AM/H22G6VMulNp8vRcZtw
	de1+BwDrIhXgk+92kQHN2VjPe+uOHkiE+0dVWBrQ=
Received: from mail.zoho.com by mx.zoho.eu
	with SMTP id 1774865691675946.9053187433396; Mon, 30 Mar 2026 12:14:51 +0200 (CEST)
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1774865691288564.2940483954262; Mon, 30 Mar 2026 12:14:51 +0200 (CEST)
Date: Mon, 30 Mar 2026 11:14:51 +0100
From: Herbert <objecting@objecting.org>
To: <david@kernel.org>
Cc: <krzk@kernel.org>, <ljs@kernel.org>, <hlcj1234567@gmail.com>,
	<sj@kernel.org>, <akpm@linux-foundation.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<kees@kernel.org>, <gregkh@linuxfoundation.org>,
	<brauner@kernel.org>
Message-ID: <19d3e3d3297.190bc89f62053.5899613485100180781@objecting.org>
In-Reply-To: <25688dbc-cd11-4137-bad4-a215198feee6@kernel.org>
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
 <6deb290e-b168-4de2-95f8-fc784ed31c27@kernel.org> <25688dbc-cd11-4137-bad4-a215198feee6@kernel.org>
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









---- On Mon, 30 Mar 2026 09:16:44 +0100 david@kernel.org wrote ----


> On 3/30/26 09:50, Krzysztof Kozlowski wrote:
> > On 30/03/2026 08:27, David Hildenbrand (Arm) wrote:
> >> On 3/27/26 16:22, Josh Law wrote:
> >>>
> >>>
> >>>
> >>>
> >>> Hello david, thanks for being polite about this whole thing!
> >>>
> >>>
> >>> so, you are talking to a real human, i promise you that now
> >>
> >> That's exactly, what I would say if I were a bot ;)
> >>
> >> As a first step, fix the line wrapping. The following document was
> >> helpful to me in the past:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0Documentation/process/email-clients.rst
> >
> > Yeah, good luck. Several people asked for that already, like 10 or 20
> > times. Andrew asked that a few times.
> >
> > And yesterday we got another sloppy posting, so that would be it for
> > having some time off to learn things and take slowly. 3 days after this
> > AI slop which does not even build.
>
> Bot confirmed, I guess :)
> --
> Cheers,
>
> David








? That was me learning the ropes, by making a patch to the QCOM subsystem


and it was a genuinely "ok" patch.


May you please tell me what I did wrong here.




V/R




Josh Law

