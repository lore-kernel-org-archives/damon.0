Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905F41C30B;
	Thu, 26 Mar 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542815; cv=none; b=ABFq97QyLKf+iVVQ2xspWcZh9V86R5AFPCoQIPKTC/tjUGgOYUKImh5kB37O7CCXp0Vt9Wa5cKDB6ghJyGtepeL6/Jilihaz8txm4kvjBXej3U4I2rsk4WLAqHiBXi5ez7dtasz5w7VP5BVs/ewIUHVGc00/xgFApIladNme2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542815; c=relaxed/simple;
	bh=URbp2t3NRtBFo93UD7u8pHbvrDeRMl30UmZHjDS47Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPIM88SivJQrZxeA3buFgFCa5MyCV/X7+rbFKNT+JaUWcefWmutU/bys7U7+WCGfg4DVxFrJpn5cbz8MYPlLzXCjB33rXEbrGEKlAhhmoyh3zSou6nX36n/h16Ryf86NmEtlpgov6i0rHV/0iX1GlXtRef628qcwtu6JFHy3DT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gneYv0EJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gneYv0EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF6CC116C6;
	Thu, 26 Mar 2026 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774542814;
	bh=URbp2t3NRtBFo93UD7u8pHbvrDeRMl30UmZHjDS47Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gneYv0EJAskmTkLQA79XtB007irpVr7UE0SNXmyK1HArCGt2lFChdhcuEHozea2Cl
	 aQWscRrFAyWiosyGNvqWsbhWOHVrasZVR5XWX1GgdfeTUrr1JP7rutza3Ka6PbelS8
	 2DA4uwxRg5LJSqKtVtg02y3StHUPKzb4VgYGujyNkWQulsF5tFzkHY8Q9w0vIBjArF
	 jlCni+m/g9w1Swv1MDpuU8bwGpd+tjDfXHnHRS6P3KoaHUPSruMMQrqkJaL3ZqdIq3
	 Q9vQDT/xC/ljOXBIeLhqhuwgJsVY4Dk7KIUebLbG7hsoyhJ0xAMzmzTcxZQ43OwzHQ
	 Tpn+iSDkJg66A==
Date: Thu, 26 Mar 2026 16:33:30 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Josh Law <hlcj1234567@gmail.com>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kees Cook <kees@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering
 module
Message-ID: <cea99016-5407-4392-9b7d-2e6a994f550f@lucifer.local>
References: <20260326072737.341964-1-objecting@objecting.org>
 <cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local>
 <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org>
 <ae7dc7de-966e-4e04-bb55-318d97c61909@lucifer.local>
 <a9f267d5-b0a3-4118-a1c2-5caa8a3b638d@kernel.org>
 <14366e29-4ee2-490e-8e4a-0c5cace1f313@lucifer.local>
 <04B79050-4353-4FD2-A596-1474BDB94B3F@objecting.org>
 <b263a722-e9b8-4a43-a075-46e4a753871d@kernel.org>
 <043CED5F-7014-4776-824E-07E027B7BDC3@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <043CED5F-7014-4776-824E-07E027B7BDC3@objecting.org>

On Thu, Mar 26, 2026 at 04:10:42PM +0000, Josh Law wrote:
>
> I will be absolutely transparent with all of you here, The commit descriptions
  (The long ones), Use AI, to be exact! Claude sonnet 4.6,
>
> Additionally, I will make a promise here,
> All of the bug fixes I made, all of my lib/ bug fixes, are made fully by me,
> (minus the commit description for some of them) And I can promise you that on
> the bible, If you have any questions about this, You can always ask me
>
> Forth thing: My patch volume
>
> To justify my patch volume, I am a "excited" Developer, I love the Linux
  kernel, and I have a passion for that, I am very very sorry I filled up your
  mailbox with my slop descriptions

You're obviously lying, and you're not very good at it.

To reiterate:

  Assessment: ~95% probability all contributions are AI-generated. The
  evidence is overwhelming:

  1. Volume is humanly implausible — ~30 emails/day, 5–10 new patch
     submissions per day across unrelated subsystems, from a contributor
     with zero prior history.

  2. Breadth is the strongest signal — no human newcomer simultaneously
     finds subtle bugs in bootconfig, vsprintf, base64, bch, maple_tree,
     assoc_array, io_uring, AND writes a new DAMON NUMA tiering
     module. Each of these requires deep domain-specific knowledge. The
     pattern is consistent with an LLM being pointed at different source
     files to systematically find issues.

  3. Bug-finding pattern — the patches cluster around unchecked return
     values, type mismatches, resource leaks, off-by-ones, signed/unsigned
     issues. This is exactly what an LLM produces when scanning code for
     potential problems.

  4. Rapid revision cycling — bootconfig went from v1 to v8 in ~1 day. This
     matches AI regeneration, not human revision.

  5. Feature additions from a newcomer — glob_match_nocase(),
     glob_validate(), debugfs BUG/WARN interface, and the DAMON NUMA
     tiering module are all non-trivial features. A first-time contributor
     proposing features (not just fixes) across this many subsystems
     simultaneously is essentially unheard of.

  6. Zero ramp-up — the contribution stream started at full throughput with
     no learning curve visible.

Please go away.

and >/dev/null to any further correspondence from you, other than NAK's when
necessary.
