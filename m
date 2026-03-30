Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911E3BA259
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867230; cv=pass; b=JElEoy7xjaPUlTWsz4LneL86yqKwnPBm8YlquHs47WMRqCtjaqKrBoLoLNwkLnLeWdYrg0DNs1U5zaGvDBsWKJgCNECoQtom8Pzf3MOZaDPGr0ysdbpuEu7E5d/X0FcNRuy+M4pET3BjUvOfMiwsUTajp6S64VBnsYZOJILpHBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867230; c=relaxed/simple;
	bh=9Edy05rDK+VJ+h+lw45MSlJhZR2FiDSi1wwiaoCifMY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KOuCLmu67lxYnv9fhCe4QLbKESwKtiNyrKzjfRJXrJX/8yG20eLP8tojCgp3v10TJV3FtQNEDVhA1NMhxEoq/8GNF3YKC0qVZ0IznuwrOUL1SKBB1pC+ZrEa0tVKar3s8+fYoZSltSB3H/GtBOUtwLpznBanbqVats2OEN9eRbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=jwyttnHn; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="jwyttnHn"
ARC-Seal: i=1; a=rsa-sha256; t=1774867224; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eq4Wv8xt4X8syBzo9UMoC3bJasr0riZjh8SlZm+zFEW8htVw2kh7tiMwyDTJCppGeAAV+OM4Mhs1oDG+Csr+2Ipir9t/XeJsiJql5amHJry9PfJoLt/xEG06p7UmPOd4SfHAaJ3eP1mo7kP/jbN4EV3Sp2syasMyj8f/1Pi2Q5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774867224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Edy05rDK+VJ+h+lw45MSlJhZR2FiDSi1wwiaoCifMY=; 
	b=XKivTI3VEcLg8LgXTLjmg2ya0JaTdeQkUqNLUoluU1y67laYou5+Q7dcSofxJP5uTagqaoKW1Wqnv6fLwTVwOTqhO/ixsCyqgTiKk+wtuZGg2Gy6tdNB0/6jQLfReDWU8322UkxrlLWuhIaDNN8KiekYYW0NmlujgyDMLpahreI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774867224;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9Edy05rDK+VJ+h+lw45MSlJhZR2FiDSi1wwiaoCifMY=;
	b=jwyttnHnxf2MyQUg6+ia7gbgq32UQ8dpxRDCLIGySrL1Audr2xnaljxT2vfGlP/J
	JOhutnqCHFOZqtQQ5qITC7YZC5Ztcb03go8dXDygJ8lXRGHpta37wjbvDu6en5OHCW3
	3GRg0KVAOZ8G/EIZnm96kLo0Vff9ZwinG2nHdPY4=
Received: from mail.zoho.com by mx.zoho.eu
	with SMTP id 1774867224395603.3742700239171; Mon, 30 Mar 2026 12:40:24 +0200 (CEST)
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1774867223428968.7644276226767; Mon, 30 Mar 2026 12:40:23 +0200 (CEST)
Date: Mon, 30 Mar 2026 11:40:23 +0100
From: Herbert <objecting@objecting.org>
To: <david@kernel.org>
Cc: <ljs@kernel.org>, <krzk@kernel.org>, <hlcj1234567@gmail.com>,
	<sj@kernel.org>, <akpm@linux-foundation.org>,
	<damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<kees@kernel.org>, <gregkh@linuxfoundation.org>,
	<brauner@kernel.org>
Message-ID: <19d3e549383.7e0593a963940.1231119311770329278@objecting.org>
In-Reply-To: <11429699-81b4-4c1e-b247-480136fd1faf@kernel.org>
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
 <82256A72-42FD-475E-935C-629964FA80E7@objecting.org> <11429699-81b4-4c1e-b247-480136fd1faf@kernel.org>
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



Ll> >>
> >
> >
> > Hello david, thanks for being polite about this whole thing!
> >
> >
> > so, you are talking to a real human, i promise you that now
>
> That's exactly, what I would say if I were a bot ;)

Well, I don't know what else to say. I have matrix and irc I guess, I can p=
rove I'm human

> As a first step, fix the line wrapping. The following document was
> helpful to me in the past:
>
> =C2=A0=C2=A0=C2=A0=C2=A0Documentation/process/email-clients.rst

Yeah.. mobile clients hurt me, I tried thunderbird and it didn't come with =
word wrapping (I was a bit angry at that), I am mostly away from my pc, (th=
e place I do patches!)


> >
> >
> > I am looking for people to personally mentor me, so i succseed in the k=
ernel
> >
> > And, I know this is unprofessinal (and im sorry!), but my github is my =
best
> friend, i have a year worth of commits for you to see publicly, also i wo=
rk
> with android custom roms. (Any questions, feel free to ask!)
> >
> >
> >
> > So yes, this is my oppotunity to be honest,
> >
> >
> > (Yes. I do use AI!)
> >
> >
> > The reason why, is im a "perfectionist", i want to start human patches,=
 but
> im scared i will get ripped apart, (or i wont get like reviewership!! Bec=
ause
> im too slow) so i use claude (smartest ai in the market), and i regret it=
.
> Like seriously!
>
> There is this nice saying "we learn from our mistakes".
>
> I still remember the first time Linus ripped apart one of my patches. I
> learned something that day.


Exactly! Mistakes happen, you learn from them, (I was stupid for breaking m=
y break...)

> >
> > Additionally, i hate being slow, im scared that the community will ditc=
h me
> if i do 1 human patch every 2-4 weeks, which is my expected time (because=
 i
> need to understand the code!!!!!)
> >
>
>
> Well, doing 8 versions of one patch set a day is obviously the other
> extreme ;) For example, there is this unwritten rule to wait ~1 week
> (and before discussions slowed down) before sending another revision.
> There are exceptions of course.

Yeah, was stupid of me ngl

> In general, we're lacking reviewers, not code contributors. So we really
> need people that can get familiar with the code and gain expertise, to
> help the project long term.

I sure can review code. I do review code for people who ask for my custom R=
OM stuff, basically they need kernel trees for it to build and stuff basica=
lly.


> Drive-by AI generated patches that mostly just consume more of the
> precious maintainer+reviewer time are rather counter-productive.

Yeah. Very stupid of me


> >
> > I would love to have a mentor to help me around, and when (if) somebody
> wants to, i promise you now, i will start making human patches, and i wil=
l
> benefit the community positively,
> >
>
> I think you had some patches accepted my maintainers, you might want to
> consider reaching out to them to see if they would be willing to help.

To be fair, Masami is extremely busy, so is seong, Andrew is "Stupidly busy=
" (his words), which is understandable because he maintains lib/ and some o=
f mm/


> But be aware that most people are extremely busy.


Same point ^

> --
> Cheers,
>
> David




V/R




Josh Law

