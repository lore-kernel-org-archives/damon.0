Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCC4119FC
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411002; cv=none; b=jhGTF9kDa+zY+Od61g/mZ7VvtH32eykTcwtNXyCLh0PpDcCiSLeTuNoe9Te1jq+uVLpvY3g3l6I3AoTFlXykHRfLlX0BqTusD3zv2PlnxiEe6BlJw+p2OEObZOvmnenQ5I06r8qH38KfFYibYUesjZo0jDbSx+rdWDO/0vfZDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411002; c=relaxed/simple;
	bh=dZs9Ib6ajGnMxo0Taj11POCdwOaKDcJSInh5pZPJG+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSIEplSxctnPZw9HwK+qLmFeejWwaW4QeRPMV1u5KfnE9StN7jRtBQlnDMK/SWtXZSH2yGEm3R5z0XvZkK1D6RDR8GxLyZC/1perOVIpUfKax7UeoZqtZH5yfzag3kk055oNaZk9uQYO/6JZqOmeAJm3wIGQ+hRERAAWhqZ/h+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LOlhvmIF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LOlhvmIF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHuns2709587;
	Thu, 30 Jul 2026 11:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iqt2s1hq4p/5rHwvwtT1k5VmvNMosI
	CBR3I5pd05C5g=; b=LOlhvmIFhW/EngAbWhcK7RbynBbOcMLn8k9M44UoY1doH4
	CQvK5x3I2gQ+I/eDxx00AjEnGtglp7EP68wc5irkslKwFXFeJyl0JpnizTObLrfc
	wnyqyVaeaaICVHqF2o3nzEsKAdgN/Yna9ginLJBQYB1NQh6VV3ax2kGWMpJVTv1w
	Whce7mFVUCRYyM740D1Il6BuX9SbUGAUDXA28opS6pOfQXzqxqb5sws7Ac3yDMnD
	KtYJdCmUTspQr6cTO/OMjZNmWB4NVe1S/2N8p4JSmv7CA0Tz7QReSsr7LIs1FL0h
	Sa1KUyP3rTtmf7GCyJSTJvX4W0zsccVa7vEHk3Xw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7qdv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:29:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBQg3P005008;
	Thu, 30 Jul 2026 11:29:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yat6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:29:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UBTQAJ43581894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 11:29:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC1C20043;
	Thu, 30 Jul 2026 11:29:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39C4320040;
	Thu, 30 Jul 2026 11:29:25 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 11:29:25 +0000 (GMT)
Date: Thu, 30 Jul 2026 13:29:24 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        David Hildenbrand <david@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>, Mike Rapoport <rppt@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, ziy@nvidia.com, pfalcato@suse.de,
        ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 07/11] mm/mremap: use ptep_get() for the destination
 PTE
Message-ID: <50dd77c0-b6cc-43e2-abd5-6d44a29b5597-agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-8-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727164715.2866609-8-usama.anjum@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V4x9pQxNwD7ZNr5cxCV2-nvUuRwrRIk1
X-Proofpoint-ORIG-GUID: V4x9pQxNwD7ZNr5cxCV2-nvUuRwrRIk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4NCBTYWx0ZWRfX0CQsHlonvlnH
 AF8GXubMVqrPdR5q2n+7Pi5IhSvnRClhhnIlGsM45pj9nS5tbh9v0OQ7ZDryymjJZRFKeKVHtnB
 2WWJA774SAFONtJMa1V+ZFbhY/GluaeNfrJWfajh0aeP9y3KCj2N7q61IT/ZcqjPD8Ux1nEITrp
 lqWGD3CVkHnuWYvD92qt1C/5PMxyLshMO14JBLRDs++WhJByj0BHkXcsWNivsbVrtdJT6sVZwbe
 dzeDGI8gWjRNMh7nT2wbxj0bb+I7NqjrGKSVMqorBDA3g5atHjQfxeyyy1zH1imIK+WiEUWLOj2
 QQUIajHJgwMTOVFObZZxwcDbjinR/ict/W/9rkboCapJlq+7peril/x1TLLHoImfIa1fT9/ascw
 AjAYP3c7Nyd6rCK2zbdbMkwiwAS4FHnHFqkFfsWMAkhtZLdazd3x2FNYbpmW9FLWL90LlaufF1X
 g6HAqpq5Re1qYW6+N8A==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b3599 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=nEq6qJbkOf9lyMFAmGoA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4NCBTYWx0ZWRfX+toP0yvqLwe3
 5MpM2JLPKFYcitSFhNnjhmLQzv/6TWy3jhaIxgQDqHwpJrQHSWwSOVkfjDxzt8TAMHiE7g64vAw
 8VzOqfzQntIJPAir8I8JMkTRPXuGciY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300084

On Mon, Jul 27, 2026 at 05:46:58PM +0100, Muhammad Usama Anjum wrote:
> move_ptes() directly dereferences new_ptep when checking that the
> destination slot is empty. new_ptep now points to hw_pte_t table storage,
> while pte_none() consumes a logical pte_t value.
> 
> Read the destination entry through the standard ptep_get() accessor before
> passing the logical value to pte_none().
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
>  mm/mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index d966ee8248b6b..ecb90ccee6fdd 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -264,7 +264,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  
>  	for (; old_addr < old_end; old_ptep += nr_ptes, old_addr += nr_ptes * PAGE_SIZE,
>  		new_ptep += nr_ptes, new_addr += nr_ptes * PAGE_SIZE) {
> -		VM_WARN_ON_ONCE(!pte_none(*new_ptep));
> +		VM_WARN_ON_ONCE(!pte_none(ptep_get(new_ptep)));

Same as the previous patch, except that I did it already:
https://lore.kernel.org/linux-mm/20260720141633.501799-1-agordeev@linux.ibm.com/

>  
>  		nr_ptes = 1;
>  		max_nr_ptes = (old_end - old_addr) >> PAGE_SHIFT;
> -- 
> 2.47.3
> 
