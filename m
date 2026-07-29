Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CCD1F418F
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325501; cv=none; b=XdAEM/tCLFwscBEKMsLnH8Sb9yP4JCs4L9e9tlju62COX7A+8Ryil5DXLd9LEibU4NFx5CCbcS59OPgEDaLaHfUGi39Aa0k0ROKTHlusHDOG55jDat8NZUg9xE67J4eOq3YQqRHdNU6iAZlLp8PA9v9HDf4B+DoiwveytyQ1/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325501; c=relaxed/simple;
	bh=ZO5VxVQKFuSsO1hmvDMPvMAMSsW2f8aJh3n5wjdxgXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k32aqrABxnRNzR8Wg+WKQLXaeUQU+iWMdim8Dwib6DSoZRyh7SKqf01VjNnIUE4jB3fIlrLSxF2nnYfNV23qdw+ZVVPcvMdWiXjra2hghUluY6+OPxIMqt5rDVtTcJdyEJHmzkYnrbksj/rT/Qpg4fLatIa1P0Lr60+aM8ma3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=szQcOSDi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="szQcOSDi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBI9Rp4077212;
	Wed, 29 Jul 2026 11:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=V/Gc5b6Kanb7gJZ6LuCqbHgIfbcHiL
	UID8lNDkmdkBk=; b=szQcOSDicNI1Fn0H7xW/dMFikndq57iS0AEADbTHurKpEJ
	rd11kf+v/K4k3OaPX2DwPIScg0o+GL2hoyX8zqoHbYXdT0lSMDdG2vUgrwbDAvmS
	GAkXnnb9JBVhPcfVoGJY1DSA/6xfq5K9WNKizak7KaKjt/Dc2/+JfX8nFAp5plmo
	u0a4AxRt+xdBtl/2NsNsMcf1ZDG6Qjqw5xDVM5TyjGqcQsLSIksGXsQcQlaj/plp
	JuFSfwIB5TVS6mlK0Oz0clytfcFfXgk9OoMJ2+E1DEvmvdCalj6j+Xxe5b2oQCY7
	x4RvKe8ts/TDSPuLOoLmIyWAmZfVZWIqbDTv23XQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd1p2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:44:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBfHNq029357;
	Wed, 29 Jul 2026 11:44:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgeadd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:44:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBiKQM31916432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:44:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 992952004B;
	Wed, 29 Jul 2026 11:44:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 288E620043;
	Wed, 29 Jul 2026 11:44:19 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 11:44:19 +0000 (GMT)
Date: Wed, 29 Jul 2026 13:44:17 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
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
Subject: Re: [PATCH RFC 00/11] mm: distinguish PTE table storage from PTE
 values
Message-ID: <e3b6dd13-2cea-4dc5-9038-a3abde71ec10-agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <2c19247e-bee6-45f4-a353-2fcc60db26e6@kernel.org>
 <7813b5fe-e767-442c-a356-afc1a5c567ad-agordeev@linux.ibm.com>
 <6db0a8c0-b500-4364-be3d-d3a537c61258@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db0a8c0-b500-4364-be3d-d3a537c61258@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dax4K8SnTqgr3j-xLBjPIG8yJ9gcxvKF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX/ftZ3NJRCmkt
 ZT14DTCChPW4KALpaDbSLe6kNr0LuWq5PiRiSqf5YTIEutfQ2Tac4sdllF74vXnFZSICYrQE0fL
 ZL/O65SEZjU3i6ZYCyIL5FE+JISdSFU=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a69e797 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=yGtF1kJb5LocEaEl6I8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX/jm6YIwwiR1F
 lZXlePH3tA598H7Fb31vSIvPJoutJ+iSssAlIclxpQnCFqgsl/QXciOAhzwZ7FFazWWtvRVdlZ9
 TvRnRR/LIbBRyOBs37OfIHHcuSChvKVhl07RqZv9bpaqy+fPsLibBtb0+CX8Q1amoqeREdzT7LS
 45c/SPprx12OPqL4uwkj2S+LtICeW20WUFSc3OlbdqoEpxGRA12dmOFjaryENCnKW/xK1Jay/U1
 kC8ReZf28BJ12s4AmwDEQcWLd+44QFBJkS+P1wHLIwJa5nPrgSvB7j/BZoiN3neZKSKOtDNSj09
 Q6tFnfgRJpTk6CRkd5peVrkT93tDejNz3zvCXWL/dWWwVW8rI18kBZ3iQaIoQ6o8M4YCglsfenJ
 wdrKMTl/qwP8vRTkJCoONCRiVYcB8Qwu+P574F7wJpa5ktjFD5+6hw8BDY0mBPrkdR2pGPZzU/d
 eAJCrvqHF5YRoCZPBfw==
X-Proofpoint-GUID: Dax4K8SnTqgr3j-xLBjPIG8yJ9gcxvKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290093

On Wed, Jul 29, 2026 at 01:05:35PM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 12:13, Alexander Gordeev wrote:
> > On Tue, Jul 28, 2026 at 09:26:06PM +0200, David Hildenbrand (Arm) wrote:
> >>> The generic definition aliases hw_pte_t to pte_t, so this series preserves
> >>> the representation and behaviour of every architecture. ptep_get() keeps
> >>> its existing READ_ONCE() semantics and converts the stored element through
> >>> __pte_from_hw(). An architecture can later define a distinct hw_pte_t and
> >>> convert its PTE interfaces to make the distinction compiler-enforced.
> >>> Architecture PTE implementations and most architecture code are
> >>> deliberately left for those later opt-in conversions.
> > ...
> >> Do you have a pointer at the arm64 part, so people can get a feeling for how an
> >> actual hw_pte_t implementation can look like.
> > 
> > May be we need the generic hw_pte_t implementation as { pte_t pte; }
> > right away?
> 
> Indeed, that makes sense. We just need a way for the architecture to opt-in that
> it did the conversion.
> 
> > 
> > Also, can you envision a case when sizeof(pte_t) != sizeof(hw_pte_t)?
> > If not, the compile-time check is worth adding.
> 
> That wouldn't work as is. We'd have to intercept ptep++ and instead have a
> helper to advance the ptep pointer.

I think I am missing the point. That is my takeaway from your previous mail:
https://lore.kernel.org/lkml/31d36023-d728-4eee-90f8-158c7066f565@kernel.org/

<quote>
>    {
>       page_table_check_ptes_set(mm, addr, ptep, pte, nr);
>       for (;;) {
>               set_pte(ptep, pte);
>               if (--nr == 0)
>                       break;
>   -           ptep++;
>   +           ptep = hw_pte_next(ptep);

We should really just let ptep++ work as before.

>               pte = pte_next_pfn(pte);
>       }
>    }
</quote>

So are we going after hw_pte_next(ptep) or ptep++?

> One idea for that would be to let the compiler catch that by marking hw_pte_t an
> undefined struct (unknown size), such that the compiler would indicate any usage
> of ptep++ properly.

What is the purpose of that? I mean when pte_t vs hw_pte_t uses are sorted
out what is the benefit of preventing hw_ptep++?

> That can be done when it would actually required, so as a first step having a
> generic hw_pte_t would just work.
> 
> -- 
> Cheers,
> 
> David

Thanks!
