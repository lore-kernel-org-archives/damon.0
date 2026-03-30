Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890111339B1
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867284; cv=pass; b=ER4cpt/JMFyRaB3D4vWdkKxzJdbu9vdrG0HUesSo5FBTcOM9ID2+TwB+hby2m9IfmH4TgeGpJbUR83fZdJvmCYKTlttjg4Isz68E5g8LUcBhmtiFilHMsA+NjTKY28hkDVPv/34oE0y1kP0iK+G5CbOMywdlXZJrltYJmJIPHgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867284; c=relaxed/simple;
	bh=1gLOxW7D1YyMkjgkNZACuXqcsJMnta+9MITqYhpWw7M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HtbBjfAtxIgGldkuUqMxl/YLVfpTa/lc0YzKyU6mjpbctyzAgQh544hXS1rnKmaNWqPs61BZLKe0s+C8fzq11LWkKVqUvpbuXHhRpM0+GHBPSXThGiwD8c31tZcZTKbsv8ikfWgVzr4Cu0zRXS9nPZqp3nReB00f2ldjv+0UI/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=GNmq0aPE; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="GNmq0aPE"
ARC-Seal: i=1; a=rsa-sha256; t=1774867278; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jElvRFtbh2Dr5cwbvr0lVMX/yO6tjM5lDEYi26SaeY7yJ9MK+ACNXtZw3F/uU5OJTHYPWAcdzCIhH2mP/K0X3bCK0aatRqR6qBhE8PWXdorQp9aQNn9khWKM9Fn7wYHBjzin29miy2W8yo+czQNx7AofKXMQ3FYPwVZWpYxAV4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774867278; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1gLOxW7D1YyMkjgkNZACuXqcsJMnta+9MITqYhpWw7M=; 
	b=XI3YiIz969zpimdjZeslludY1iQhXB6HWdpXyvQkLQ+wOR5d5cGvS0ktDM0jYX+kmr1iTZgHi4RB1NZ3w8lJr3FWhkDungAjJ+215f+1nf0XyOXaM0c0lyRnsK2V5cFTCLuizAKZmO5I0B2fuGC4Es0unraJvuS+ZWL5U506QfM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774867278;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1gLOxW7D1YyMkjgkNZACuXqcsJMnta+9MITqYhpWw7M=;
	b=GNmq0aPEp7ZA2jnvTYdlmXaJfxahukN4yVraQCr2iW8KCq0jJs42ZvgUnUOclH+n
	m+jbw83v8x+bA4HvvYsY5YOPKE7TlV0+r+hsMH9lER53ZtVHbx/kgZu6aCCOAFnkV64
	4jHT4gzdcoGIJ4JjUJAjIR+rNse0BcLWBrQHW2dI=
Received: from mail.zoho.com by mx.zoho.eu
	with SMTP id 177486727888129.864738753605025; Mon, 30 Mar 2026 12:41:18 +0200 (CEST)
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1774867277943384.19373731732355; Mon, 30 Mar 2026 12:41:17 +0200 (CEST)
Date: Mon, 30 Mar 2026 11:41:17 +0100
From: Herbert <objecting@objecting.org>
To: <david@kernel.org>
Cc: <krzk@kernel.org>, <ljs@kernel.org>, <hlcj1234567@gmail.com>,
	<sj@kernel.org>, <akpm@linux-foundation.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<kees@kernel.org>, <gregkh@linuxfoundation.org>,
	<brauner@kernel.org>
Message-ID: <19d3e556876.698a550f63973.7445500539418743220@objecting.org>
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
Content-Transfer-Encoding: 7bit
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
> >>> having some time off to learn things and take slowly. 3 days after this
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
> > ? That was me learning the ropes, by making a patch to the QCOM subsystem
> >
> >
> > and it was a genuinely "ok" patch.
> >
> >
> > May you please tell me what I did wrong here.
> I thought you wanted to "take a couple months break"? And I suggested
> getting a mentor first.
>
> Anyhow, this mail was sent from "Herbert", which is quite ... confusing.
>
> --
> Cheers,
>
> David




sigh, I need to fix that, my friend helped me do this, and for some reason the name change didn't appear, which is weird

