Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF440148E
	for <damon@lists.linux.dev>; Thu, 26 Mar 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538052; cv=pass; b=E0hUrY8ZFLSLkbXPEIbd2nkvsVBkBMoehRpM3KzHuh0ORxp8S/QWV2lgtdjAh0udWn3CRv74XKUjHtQziwwM+PVIecRQqigec7kpyAT86AepqXMobSuyAtLDo0k89UqDvxwOliL9SvlQji1uzCJaHTJsPliFPkFPyXQZ0bA4nOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538052; c=relaxed/simple;
	bh=uSvH8cFU5J/dTrBfW8lL79Yfd8NyTh0qiTLmPO4AC7k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lN6HYJQgHKOmKo/+V2kctMmETKypv+pRMFnAOM+gnlGtejrqsegx3l9qE/J2wqXW4gfrfNu8SDHjgGKTx6G1sJl0q8quAak+Nf7IBZx0Vo4nUj6sv7VvUzMB8zU8CDDYjHvge464kR1gFy7VRzSHxLXZn54vuUp4o/8myx2wRr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=S/BH4/xl; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="S/BH4/xl"
ARC-Seal: i=1; a=rsa-sha256; t=1774538046; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Y9XZZ4kKSmeSqiPZjpIenVmidlXU1e7erE+3Xg3n22nBtrgIG+8Yiq1Q/D62QNgjISHvhxsUfxBsE3Qa2X8HYJ9umRm8K2pV6qvuOswP28mY7nUlAP8NeURij9JTB6gTWCuqKU3nBHQa1nX75d94tmDT+gMM4fPfV3RTmsGO8Gk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774538046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i1zaRwQyLd+YNeZI98XQVtT7JyYsfiymY9H7SUMd4Ik=; 
	b=d63rOhvKXo0D7mXUBNm4oC+0d2+BrkNJve2GqGQARZdz39Thei6gZAJ3ytTNVIwWg6n0XOv3vCCKSx4Ku0cczYFfY1KOq68NABrWuIuqkLI+Nc7zSev2eOFdxAyYhMOu9067FztYXha/NTVqQEWHhfQOqkwU07ETfw9GM8ihcns=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774538046;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=i1zaRwQyLd+YNeZI98XQVtT7JyYsfiymY9H7SUMd4Ik=;
	b=S/BH4/xl9vXF7g44sHv/eUHDjHmOsdPOKAiCeXbiiqdQ/1SSJ5NqHAVw/CaJRfkm
	xATniUG5/SyX12lH8ZN5ZCTFCdrEETv7UnL3/62rYNjgjgaC9vH3aGQ6Y2GpQM16oAN
	HNJWi2HQxD1VxH8vX/v4AIFOgZDauY/UIRbQYK0I=
Received: by mx.zoho.eu with SMTPS id 177453804433515.34994021699606;
	Thu, 26 Mar 2026 16:14:04 +0100 (CET)
Date: Thu, 26 Mar 2026 15:14:01 +0000
From: Josh Law <objecting@objecting.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
CC: Josh Law <hlcj1234567@gmail.com>, SeongJae Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/damon=3A_introduce_DAM?=
 =?US-ASCII?Q?ON-based_NUMA_memory_tiering_module?=
User-Agent: Thunderbird for Android
In-Reply-To: <14366e29-4ee2-490e-8e4a-0c5cace1f313@lucifer.local>
References: <20260326072737.341964-1-objecting@objecting.org> <cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local> <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org> <ae7dc7de-966e-4e04-bb55-318d97c61909@lucifer.local> <a9f267d5-b0a3-4118-a1c2-5caa8a3b638d@kernel.org> <14366e29-4ee2-490e-8e4a-0c5cace1f313@lucifer.local>
Message-ID: <04B79050-4353-4FD2-A596-1474BDB94B3F@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 26 March 2026 12:50:40 GMT, "Lorenzo Stoakes (Oracle)" <ljs@kernel=2Eor=
g> wrote:
>On Thu, Mar 26, 2026 at 01:40:19PM +0100, Krzysztof Kozlowski wrote:
>> On 26/03/2026 13:29, Lorenzo Stoakes (Oracle) wrote:
>> >>
>> >> Answering to reviewers with whatever confirmation they look for is a=
lso
>> >> a warning sign of non-trustworthy behavior=2E Or rather behavior try=
ing to
>> >> get trust=2E
>> >>
>> >> [1]
>> >> https://lore=2Ekernel=2Eorg/all/D47F8215-FD08-45ED-AB01-0A5C48CD41DD=
@objecting=2Eorg/
>> >>
>> >> [2]
>> >> https://lore=2Ekernel=2Eorg/all/2F84DD09-2880-45E0-AA98-204F10848F85=
@objecting=2Eorg/
>> >>
>> >> Best regards,
>> >> Krzysztof
>> >
>> > Yeah this is really adding up to somebody abusing the kernel process=
=2E I think
>> > 'Josh Law' or any other pseudonym that can be traced back to whoever'=
s behind
>> > this should be banned from the mailing list altogether=2E
>> >
>> > Also, as per Christian ([3]), it seems this guy was using the pseudon=
ym
>> > "techyguyperplexable"=2E
>>
>> Yes, repos on that Github carry commits like:
>>
>> commit c04af501bacbef54cf97cdfb904ddf295f8327c1
>> Author:     techyguyperplexable <objecting@objecting=2Eorg>
>> AuthorDate: Sun Jan 11 04:21:53 2026 +0530
>> Commit:     techyguyperplexable <objecting@objecting=2Eorg>
>> CommitDate: Sun Jan 11 04:21:53 2026 +0530
>>
>>     ANDROID: sched/rt: reduce lock hold time in update_curr_rt
>>
>>     Move resched_curr and do_start_rt_bandwidth outside the spinlock
>>     critical section to reduce lock contention
>>
>>     Change-Id: I8dfb4e33460ae4eeb0bb854cc2cb084ab5edf7e4
>>     Signed-off-by: techyguyperplexable <objecting@objecting=2Eorg>
>>
>
>Thanks, it looks pretty clear cut then that 'Josh Law' is an openclaw bot=
=2E
>
>To think he was scheduled to be added as a reviewer for literally all of =
lib/
>recently (5) until various of us pushed back on it :/
>
>[5]: https://lore=2Ekernel=2Eorg/all/20260308202425=2EC9EE4C116C6@smtp=2E=
kernel=2Eorg/
>
>Is it really that easy to game the system?=2E=2E=2E
>
>I hate the asymmetry of this - we have to jump on these every time and th=
ey can
>send WAY more mail than we can reasonably reply to=2E
>
>I think we need a clear 'yeeting' mechanism to block these people on ever=
ything
>once discovered=2E
>
>Sadly the kernel has been historically very poor on getting rid of proble=
m
>people (The CoC is essentially a swear monitor at this stage)=2E
>
>In the face of this new kind of threat we probably need to do a lot bette=
r=2E
>
>> >
>> > There's a github with the same name ([4]), and that same user made a =
comment on an
>> > openclaw issue relating to linking it to gemini ([5])=2E
>> >
>> > So it seems likely he/she is likely using openclaw to fully automate =
this 'Josh
>> > Law' user and we're speaking to a bot here=2E
>> >
>> > (Screenshots have been taken for the (possibly inevitable) deleting t=
hat will
>> > happen later=2E)
>> >
>> > [3]:https://lore=2Ekernel=2Eorg/all/20260313-halskette-annahme-94e782=
eb4ae4@brauner/
>> > [4]:https://github=2Ecom/techyguyperplexable
>> > [5]:https://github=2Ecom/openclaw/openclaw/issues/44134#issuecomment-=
4106247302
>>
>>
>>
>> Best regards,
>> Krzysztof
>
>Thanks, Lorenzo


Hello! Wow i came back to a lot=2E


I can promisw you now i am a human, hand on the bible, and i will improve!=
=20


So i will add assisted by to any commit descriptions written by AI, or any=
thing even touching AI, i understand your apprehension and i apoligize very=
 deeply=2E


V/R


Josh Law
