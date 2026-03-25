Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D0311975
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455378; cv=pass; b=JqZEHv0Ha7ZAPgy3isyAjbGA4Cczx5pVPL+9YpxgIE4djZThz9EKvzRm2qjmYN4wIGmSSLFqmeqIsOZyqWzxxsYH8x8uyG5ywUvbIX3W585bYHEek2jd1Gzkh7LC0C09JImuJPvx79N8R/OWLtDNsN7vnJ55/iD0OqDxM9uawrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455378; c=relaxed/simple;
	bh=mNPI9LyMIqGzr8Z5IarmSD68pFVut4Ky50UZzeD3kHs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KyU/277Tg0xEHaf03RTj6N4wyQnSN1e9FNFaj0SoSskcvDlG0cMQn8iuePN5SwHuuBb7aiDsNdYfz8xJk7fjinp6fxDKnfKxLju5PgBIv+dnQelU8mcMXIdp7s4MC3iFnP5wWP5S9VsTcOQ0EzpPGV5f3N9gx7NsTCCyUIrU+l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=myZrM+wS; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="myZrM+wS"
ARC-Seal: i=1; a=rsa-sha256; t=1774455372; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Q0mvmx/M/1A/VcQ7qnjKeX7/KR44YhnIrgtDDcTGj3Eawk6qZnldXUPMiolA+2/aJkh0xPqeo70lNX6IvvYVn8flUG53DLynQPszsSO7KhMKH8eUgm4hPcAqEVRn+UgSexg2dFf/snONwQN73Npbw9w8dBaxLrlfAv+mDZiH6h8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774455372; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R/nrZmK39p9F4RJ/sZwnZUtTLQN/VBhXeb5KAM1XOdk=; 
	b=ecf1h9vVR/5HP7w1L4rJ6kJvF0JZt4m+Ko7Z/gQhn8cWue7DQ/a/JrV+jJzw9G963hKmz0ZeslDDg8X6leq2ZkCfhuhqWedByKb1uM05on4s6xcBnEE59GNsKvjRaeMqN+cihhR6ZNM88Ai5EWP0jTQCBEyJrGU2t5QU2LXEGww=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774455372;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=R/nrZmK39p9F4RJ/sZwnZUtTLQN/VBhXeb5KAM1XOdk=;
	b=myZrM+wSJDOyKO8ul1y9lOZHFxcxyxelho03uA0iaUZRIFnYmAbhPyF35JXuHl+c
	S+myA8wDFF47TI89FiIJkogAnqj9xpWaEQNbb+rhHuxCQwM71+nvuPP3OCEDvNPBoLz
	PsKCGN+IxP3kIU//e3wTxSpE8fUN4K2qm7T8LIes=
Received: by mx.zoho.eu with SMTPS id 1774455368916960.7489889559625;
	Wed, 25 Mar 2026 17:16:08 +0100 (CET)
Date: Wed, 25 Mar 2026 15:44:56 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=28sashiko_review=29_=5BPATCH=5D_mm/damon/core=3A_?=
 =?US-ASCII?Q?validate_goal_nid_before_accessing_node_data?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260325150411.88357-1-sj@kernel.org>
References:  <20260325150411.88357-1-sj@kernel.org>
Message-ID: <EC4DB612-96E6-4BF3-8F46-BEB18FC488D0@objecting.org>
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



On 25 March 2026 15:04:10 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Wed, 25 Mar 2026 07:37:39 -0700 SeongJae Park <sj@kernel=2Eorg> wrote:
>
>> Forwarding Sashiko review for doing discussions via mails=2E
>>=20
>> # review url: https://sashiko=2Edev/#/patchset/20260325073034=2E140353-=
1-objecting@objecting=2Eorg
>> # start of sashiko=2Edev inline review
>> commit 7e17cbe1dc95a0cd1a1410be38ab6964f78fb15c
>> Author: Josh Law <objecting@objecting=2Eorg>
>>=20
>> mm/damon/core: validate goal nid before accessing node data
>>=20
>> This commit adds bounds checking and node_online() validation for the
>> goal->nid in the DAMON quota metrics=2E It prevents out-of-bounds acces=
ses
>> to NODE_DATA() when an invalid or offline NUMA node is provided by user=
space=2E
>>=20
>> > diff --git a/mm/damon/core=2Ec b/mm/damon/core=2Ec
>> > index db6c67e52d2b=2E=2E81ce27baa1a1 100644
>> > --- a/mm/damon/core=2Ec
>> > +++ b/mm/damon/core=2Ec
>> > @@ -2245,6 +2245,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
>> >  	struct sysinfo i;
>> >  	__kernel_ulong_t numerator;
>> > =20
>> > +	if (goal->nid < 0 || goal->nid >=3D MAX_NUMNODES ||
>> > +	    !node_online(goal->nid))
>> > +		return 0;
>> > +
>> >  	si_meminfo_node(&i, goal->nid);
>> >  	if (goal->metric =3D=3D DAMOS_QUOTA_NODE_MEM_USED_BP)
>> >  		numerator =3D i=2Etotalram - i=2Efreeram;
>> >  	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
>> >  		numerator =3D i=2Efreeram;
>> >  	return mult_frac(numerator, 10000, i=2Etotalram);
>>=20
>> Could this cause a division by zero if the node is online but memoryles=
s?
>>=20
>> For CPU-only compute nodes or nodes where all memory has been hot-remov=
ed,
>> node_online(goal->nid) will evaluate to true=2E When si_meminfo_node() =
is
>> called for these memoryless nodes, it populates the sysinfo struct with
>> i=2Etotalram =3D 0=2E
>>=20
>> The mult_frac() macro unconditionally performs integer division and mod=
ulo
>> by the third argument, which could trigger a kernel panic when dividing=
 by
>> zero=2E
>>=20
>> Would it be safer to check if i=2Etotalram is zero before returning, or=
 use
>> node_state(goal->nid, N_MEMORY) instead of node_online()?
>>=20
>> [ =2E=2E=2E ]
>>=20
>> > @@ -2261,6 +2265,10 @@ static unsigned long damos_get_node_memcg_used=
_bp(
>> >  	unsigned long used_pages, numerator;
>> >  	struct sysinfo i;
>> > =20
>> > +	if (goal->nid < 0 || goal->nid >=3D MAX_NUMNODES ||
>> > +	    !node_online(goal->nid))
>> > +		return 0;
>> > +
>> >  	memcg =3D mem_cgroup_get_from_id(goal->memcg_id);
>>=20
>> The same division by zero risk exists here when mult_frac() is called a=
t the
>> end of this function=2E
>
>I think sashiko's comments make sense=2E  I also suggested using
>node_state(N_MEMORY)=2E  What do you think, Josh?
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Yep, will do
