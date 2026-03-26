Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A383090D9
	for <damon@lists.linux.dev>; Thu, 26 Mar 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543248; cv=pass; b=D60F7pTs3wLXNb6nen3y/P5RcNycO+MZk1A20MWS1HktSz3x10myTa1rayVwKKPr/zESQAIwkNUOxvL7PjxTmGrkgTTkbJt9NhmmD3l54acf+veNj3dIapxpAB0AGzePigmOrBWaE5n4RKD4jnrLko5XGwMqTXwNg8z2Hlzu34g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543248; c=relaxed/simple;
	bh=uz7Xzto1NAUFP2HsxBSJaM9rxMZS1Q2L67M4E9S9UTI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uEdABil3Fl/AZbL34OEqJ6DWjjD/EZsrbEOSpoNyY1hx7oXe8yRgtAtuJvZL2RS6AuHOfqD8c5JtJNHG9fX2f7TLnK7XCzec8RcLt9ZMESSqrVmCtp1z9j0g7yXe+PA0gvr1YME+3CSH7WGIjH5tL95Qndn0iqDnF/CWqdf/ov8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=MvVfAHOF; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="MvVfAHOF"
ARC-Seal: i=1; a=rsa-sha256; t=1774543242; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gQjRr2k5TprDysxV6vXubqEUpN4oxQwBUxZ8r1QhyZpMMrwtbElXwQw3IwldBfRpP8xwRCFT5bw9kIFKSMBAygPqpuEembZHcBjL6PhVdwpZhtV6oA/F5V6mCeQ8Nyv9H/LBvz1Tq/UHRuq1o1BaMD8/gzcBzjfJ1Z6L49T4VPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774543242; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jK6Uz6T7OCeiZ6ME5STgQy0ZxUTHM7aH7G9hl9oeWnc=; 
	b=X5vseiur9iOXKLL8cXw46r+ssuC7cyOskgS1J+LIprrA3pPR0cwGwxvB4FduiFf3xoORTHMT5Ae4i9YwtWcMZbqcrgA8+a+4N8R8okaKg5y9/+TrmptZB4Xu1MFOrpO7NVgjPKzXI+HmAgrfuCXQ7JX3He5VtFMneNo6nyNV/kU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774543242;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=jK6Uz6T7OCeiZ6ME5STgQy0ZxUTHM7aH7G9hl9oeWnc=;
	b=MvVfAHOFH8ma5uLR0bv6GIuZ56wli1Cr1+SOrV2LiOFmuvX8FOH9XciryNs5Orw5
	DU3oDrQF/lHl/2OYME7NM7KtaOrD6R2c+aweDTXP66PmsuYCIHllzpo+pdFOlbyLN2M
	rIxoJ+y4IJMMBbxjWuIPwAmep7IVIPxCP3q1/Q6U=
Received: by mx.zoho.eu with SMTPS id 1774543240502241.26226366341768;
	Thu, 26 Mar 2026 17:40:40 +0100 (CET)
Date: Thu, 26 Mar 2026 16:39:54 +0000
From: Josh Law <objecting@objecting.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Josh Law <hlcj1234567@gmail.com>,
 SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/damon=3A_introduce_DAM?=
 =?US-ASCII?Q?ON-based_NUMA_memory_tiering_module?=
User-Agent: Thunderbird for Android
In-Reply-To: <cea99016-5407-4392-9b7d-2e6a994f550f@lucifer.local>
References: <20260326072737.341964-1-objecting@objecting.org> <cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local> <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org> <ae7dc7de-966e-4e04-bb55-318d97c61909@lucifer.local> <a9f267d5-b0a3-4118-a1c2-5caa8a3b638d@kernel.org> <14366e29-4ee2-490e-8e4a-0c5cace1f313@lucifer.local> <04B79050-4353-4FD2-A596-1474BDB94B3F@objecting.org> <b263a722-e9b8-4a43-a075-46e4a753871d@kernel.org> <043CED5F-7014-4776-824E-07E027B7BDC3@objecting.org> <cea99016-5407-4392-9b7d-2e6a994f550f@lucifer.local>
Message-ID: <E1A667AB-DCE4-4034-A36B-DAA458780A81@objecting.org>
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



On 26 March 2026 16:33:30 GMT, "Lorenzo Stoakes (Oracle)" <ljs@kernel=2Eor=
g> wrote:
>On Thu, Mar 26, 2026 at 04:10:42PM +0000, Josh Law wrote:
>>
>> I will be absolutely transparent with all of you here, The commit descr=
iptions
>  (The long ones), Use AI, to be exact! Claude sonnet 4=2E6,
>>
>> Additionally, I will make a promise here,
>> All of the bug fixes I made, all of my lib/ bug fixes, are made fully b=
y me,
>> (minus the commit description for some of them) And I can promise you t=
hat on
>> the bible, If you have any questions about this, You can always ask me
>>
>> Forth thing: My patch volume
>>
>> To justify my patch volume, I am a "excited" Developer, I love the Linu=
x
>  kernel, and I have a passion for that, I am very very sorry I filled up=
 your
>  mailbox with my slop descriptions
>
>You're obviously lying, and you're not very good at it=2E
>
>To reiterate:
>
>  Assessment: ~95% probability all contributions are AI-generated=2E The
>  evidence is overwhelming:
>
>  1=2E Volume is humanly implausible =E2=80=94 ~30 emails/day, 5=E2=80=93=
10 new patch
>     submissions per day across unrelated subsystems, from a contributor
>     with zero prior history=2E
>
>  2=2E Breadth is the strongest signal =E2=80=94 no human newcomer simult=
aneously
>     finds subtle bugs in bootconfig, vsprintf, base64, bch, maple_tree,
>     assoc_array, io_uring, AND writes a new DAMON NUMA tiering
>     module=2E Each of these requires deep domain-specific knowledge=2E T=
he
>     pattern is consistent with an LLM being pointed at different source
>     files to systematically find issues=2E
>
>  3=2E Bug-finding pattern =E2=80=94 the patches cluster around unchecked=
 return
>     values, type mismatches, resource leaks, off-by-ones, signed/unsigne=
d
>     issues=2E This is exactly what an LLM produces when scanning code fo=
r
>     potential problems=2E
>
>  4=2E Rapid revision cycling =E2=80=94 bootconfig went from v1 to v8 in =
~1 day=2E This
>     matches AI regeneration, not human revision=2E
>
>  5=2E Feature additions from a newcomer =E2=80=94 glob_match_nocase(),
>     glob_validate(), debugfs BUG/WARN interface, and the DAMON NUMA
>     tiering module are all non-trivial features=2E A first-time contribu=
tor
>     proposing features (not just fixes) across this many subsystems
>     simultaneously is essentially unheard of=2E
>
>  6=2E Zero ramp-up =E2=80=94 the contribution stream started at full thr=
oughput with
>     no learning curve visible=2E
>
>Please go away=2E
>
>and >/dev/null to any further correspondence from you, other than NAK's w=
hen
>necessary=2E


I am withdrawing all pending patches, I am not gonna even touch artificial=
 intelligence again, and I am going to take a couple months break


Goodbye=2E


Josh Law
