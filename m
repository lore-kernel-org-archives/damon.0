Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1E451984
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085951; cv=none; b=DKIH7FRFw5uS560WUnH80IR2yDwsGhtMcUkfvoSYqlVmHPga+QB0Tz9pkWymiUbyKzmGOGOYU3faW+IMXB+dOgoiaI54WFzAQ77t3N9ATihJHkah9mAA7HuWh3OzS6wEuZBUv3ah3aLXvGpMWEHvdSrENPVfUTXSDjTRqdsoF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085951; c=relaxed/simple;
	bh=wXVfqEMAbawB8MPO0UhUwCJPPfwfB0Bx4TSGkqK+SO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLo+xTr+O3RjUuitu8rfTgMRtF5ZHvufYdmbb4zRDgOfEuFL0KVEfKA61aLzooE2LEOn6FLaA4RiiDS48F/2kS8onp3lykLLnghXj8XKi9pAMucubbiDYjVZaTI+KWg8pG+0ZfkSfJhz9c+lqzEqmL7fF8t/AnmDzjHcxYeRxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b6abVgzg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b6abVgzg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Huoo016275;
	Fri, 7 Aug 2026 06:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ra4H8CAbtiN9wPr1aKFBAag6HNf0qB
	uveAYY5O5upyA=; b=b6abVgzghGiyJP2Wlz0QxQ4Xlm4EEGD9Kpi/bbrlqUSFBE
	peaClBZE7a6uUDxpMzlqxLdBYmzJ2Zv0Gov1Z/ABs95zQALrNBxETA0/pEucil/j
	W+YyJwlwpe3OK1MAOCII7fcp3YeD9G589urjh/7H6praJpDu3PDyifCYlbxg55Wq
	kegIhHrXFaKgEStmSWQn7LYsur2nUZn/xPNaUh2EUQxX/E75LETTqXwjtCkcIvTM
	6z2V+hipWhFW5E/1SdFcNJm3hHGg12nD12POK8woGUy/Cd3cVuoSGV0jyJiT1nQe
	XgoPgNhStcc1pjBG2Dfbs0hQJW5cw8oy/wETB5bQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00am7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 06:58:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6776uLDe003221;
	Fri, 7 Aug 2026 06:58:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qxspg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 06:58:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6776wSir33882500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 06:58:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B0620040;
	Fri,  7 Aug 2026 06:58:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4351E20043;
	Fri,  7 Aug 2026 06:58:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.55.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 06:58:26 +0000 (GMT)
Date: Fri, 7 Aug 2026 08:58:24 +0200
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
Subject: Re: [PATCH 6/9] mm: convert PTE table entry to pte
Message-ID: <fab9fc78-1e1d-4d5b-a9ca-92f3ebd04108-agordeev@linux.ibm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-7-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806083926.1807279-7-usama.anjum@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA0OSBTYWx0ZWRfX3Npn1dSDlp+R
 fqhR9MpXZOAAKnyVJ8e3VxdJ3uPpsfM7vsZzpddpvCei+hGCUgHlBFVERXxX+W23gcpS04A1TAu
 ZsTRXf6ZMD17BVZmsTCM0lUCa3PumjU=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a758218 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=MkxDnzPc83ckttyupOUA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 9g22-5Yiq-VIyR9utDe_g8M8U8wsuEOd
X-Proofpoint-GUID: 9g22-5Yiq-VIyR9utDe_g8M8U8wsuEOd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA0OSBTYWx0ZWRfX4qeGdjjX3Iob
 oR2d/W90tNYt47jYoawp2wnB7y1FcZkNxxg7/PT57hDZR5feFluugIlRZ22mBQ/td/U5spNK5Sw
 r8fBBZDJMOMHDyBDHn28hS5vFD1IBzJcw9uh6xxZ9XoecZCsQnhJUSSf9noMzRB2RMvDZxhPIkf
 XMKQ1X4w4JsUHL/vsYXt9nxlaz1I/q7ljQgCtXwMvAVt1kijbs35mMQ7c76oGi39I1XSIpxXjmb
 kIMcLde1EyTpmQmaPbN+E3LbUk4M/lkkgjjjvsZIBgTXWy3e0GMD7NaUrStoYwo4ESb8Z4Wsdqh
 +581CUAUBwBVUa2TokmdsZzGbrL67tdrfft71SfQsy0ZlWFNR+iL1PR2Oez6zshpb+e7rynA9dG
 f8FbSxO38FmGhTq0nvrdQcjHK2fKXR2vKx64CE0UHGLhgbh7cUWWpBSkiNUoiKjHZV0BphvCO4H
 jlupay2/A2mIbK8uZUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070049

On Thu, Aug 06, 2026 at 09:38:44AM +0100, Muhammad Usama Anjum wrote:
> The non-MMU stub receives hw_pte_t but returns a logical pte_t
> value. Convert the stored entry through __pte_from_hw() before
> returning.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
>  include/linux/hugetlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index bc0b9c65aa1d0..9e8b391aa4bc9 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1283,7 +1283,7 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  #ifdef CONFIG_MMU
>  	return ptep_get(ptep);
>  #else
> -	return *ptep;
> +	return __pte_from_hw(*ptep);

But this is a direct dereferencing, which breaks the whole point, isn't it?

What about introducing something like pte_t ptep_get_sw(hw_pte_t *ptep)
to be used in exactly situations like this? With that the semantics of
hw_pte_t pointers becomes straightforward and closes the still ongoing
"storage vs lifetime" discussion:

hw_pte_t*     points to HW-formatted page table entries

ptep_get()    is used to obtain HW-linked/attached entries, and may wire
              extra code like [1] or [2]

ptep_get_sw() is used to obtain HW-unlinked/unattached entries and in
              most cases is just a direct dereference

The caller should always know whether the entry is attached or not, so
confusions like [3] are avoided.

1. https://lore.kernel.org/linux-mm/20260526-kpkeys-v8-21-eaaacdacc67c@arm.com/
2. https://lore.kernel.org/linux-s390/650903a4-0dd9-4e6b-9d4b-3c32c5657236-agordeev@linux.ibm.com/
3. https://lore.kernel.org/linux-s390/b44e071d-7c9d-4e7e-a84d-4af3499a5a05@arm.com/

>  #endif
>  }
>  
> -- 
> 2.47.3
> 
