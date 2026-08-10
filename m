Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220539A04F
	for <damon@lists.linux.dev>; Mon, 10 Aug 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344314; cv=none; b=INviZmT+4FZIiG3hj8htwDCbBff9fATNYIi6rAu2Zj4Qn+4dQnFv7LVtJBuxdpgo80Yy2hDKTJjoE8dNyorFgifTpgs8dnwVJEAulo1l52w8P5XDzW9ebS4K/voJOO6hRIetg0hmrq4xQ7JeTyQHB5CFIdTutSg0RsVnn7Zkw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344314; c=relaxed/simple;
	bh=46c6vocBVce9Y/Apjkez7FMUK7jmFceu+6/gfgpl9AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8QCAJVOCEp1mHOYSs5IVRYEpRdCbnVLYgAjtM5FiL3aBrFlVoW5oeDdIaj9XweWs53/H5wa5iX5IbqsBOriSyTHJiAqaA2Pw9sUu6MLhthnlvQTNubX5bCgIVfP940k6M6ZgcQlNXXXquka8pDzF2oLaQWfuJanL9si5STpmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cP2dX1rq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cP2dX1rq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5VYZX3085069;
	Mon, 10 Aug 2026 06:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vVPGPVZ23NsreeExE7+jGCM0ud2bcA
	JA4ypv1DILR34=; b=cP2dX1rqRgJGyJQPsc4KFbE1PC99K1ErC8LoPBcJX/kDVk
	D9Jo4Iz1SXdFchU8Ko5W4WB9COXrRcti5DpxhwdI5dfEePzz5UmgRzT8EYYyBi07
	KU36zRJaFsP0Akw7apyJ4SCl4IAb1VRGvP8L0mKhwBZnn0XUkDZ2PW7t9oviZUQq
	bN2tmVBhSWNgiSiSi7ymdtf6iKh4gNTCCXIweHK0Tg6HF6KYslOZj/J1AEcJVHnf
	kWNlsq5fwLgQr2DlUZF0whZYM5XqlyiEV4xJgAR6wPkWOH+OEMcVL/bVHH8IYS6D
	MxDe73qz6EXJrcPmB5P+oxGbZoA1keo68zERDcAg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjypkqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 06:44:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67A6ffw0026503;
	Mon, 10 Aug 2026 06:44:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxueyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 06:44:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67A6iYQG34930976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 06:44:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17B532004B;
	Mon, 10 Aug 2026 06:44:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2335D20043;
	Mon, 10 Aug 2026 06:44:31 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.135.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Aug 2026 06:44:31 +0000 (GMT)
Date: Mon, 10 Aug 2026 08:44:29 +0200
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
Message-ID: <2599c5b3-e8ac-4865-993b-d41e6f060d52-agordeev@linux.ibm.com>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-7-usama.anjum@arm.com>
 <fab9fc78-1e1d-4d5b-a9ca-92f3ebd04108-agordeev@linux.ibm.com>
 <5c329236-7761-4e42-a549-b822e43b4358@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c329236-7761-4e42-a549-b822e43b4358@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA1NCBTYWx0ZWRfXxI/cthX2D0Wc
 iHPLS8hc2Kj/zk+XaKiAAFgipdFaX6yt5ULiZYFw9cMykKZhsGzYdz8Ozez/WjJFTxNxMxdlY+Z
 xRKD8hb46fc3eq4T3zk/Ay2gFewaqBQyLERBaqjOrmguPqyfrY4V/sj3PMJQSwHxbC9gQ3JPdGp
 nwoFQng/LWfi/b2CNXX0ejbyTRbXCpU6ISkPy5ReFIqwletsdYxZQh3JZdOlQrUjBCsND1GblNt
 G/4DaSrhSqHIA4lB3PliH1JLOCq/gqtakESjF4VI9bapYhuQXt1SuBKOBQMvOtnuq4THGnpYdaA
 9DlU8ZKdg0fttjy6cWWMXxwJNMzsJQnfWACC9mQPG3O4x/cS3d0NgAmCjmdVYfXi8XGUV9/5PxJ
 HdlkuRfRyvN/kE+SQ4EeTy+wa+g6t6URPTCSrkC11WsiBzyO9FuJFEs1QK/7K/rvQyfHrqCYbs4
 iMEVrVdUzEx5zR0r21A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA1NCBTYWx0ZWRfX9Ko1NY31ilHb
 y/krrlO5A2ANnAiXusNks5NMrWI4UvS7c1Y7yzgoGS6CxTGjDGRyAu8EHxJ1ITitPdxPjbMc8pe
 lyb7xPyJDB1SIBriSbnTKYVPxMcf33w=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a797355 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=2hzp2EkNZNX3k9pX5ccA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: YbHEwP5JTLZr3QYF8zr2RkJeozrhuIz7
X-Proofpoint-ORIG-GUID: YbHEwP5JTLZr3QYF8zr2RkJeozrhuIz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100054

On Fri, Aug 07, 2026 at 05:26:04PM +0100, Muhammad Usama Anjum wrote:
> On 07/08/2026 7:58 am, Alexander Gordeev wrote:
> > On Thu, Aug 06, 2026 at 09:38:44AM +0100, Muhammad Usama Anjum wrote:
> >> The non-MMU stub receives hw_pte_t but returns a logical pte_t
> >> value. Convert the stored entry through __pte_from_hw() before
> >> returning.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> >> ---
> >>  include/linux/hugetlb.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> >> index bc0b9c65aa1d0..9e8b391aa4bc9 100644
> >> --- a/include/linux/hugetlb.h
> >> +++ b/include/linux/hugetlb.h
> >> @@ -1283,7 +1283,7 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> >>  #ifdef CONFIG_MMU
> >>  	return ptep_get(ptep);
> >>  #else
> >> -	return *ptep;
> >> +	return __pte_from_hw(*ptep);
> > 
> > But this is a direct dereferencing, which breaks the whole point, isn't it?
> Yes, this is particular line is for non MMU. In this case, CONIFG_ARCH_HAS_HW_PTE
> would never be defined. Hence hw_pte_t is just pte_t and direct dereference is
> allowed. I'd thought a lot about it; is better to leave direct dereference here
> or use some helper. Then used __pte_from_hw() was already being used in generic
> ptep_get().

But in case CONIFG_ARCH_HAS_HW_PTE=n __pte_from_hw() is still gets called.
That looks inconsistent to me. Why not just call ptep_deref() (see below)?

> There are only two users of __pte_from_hw() at this time. 
> 
> > 
> > What about introducing something like pte_t ptep_get_sw(hw_pte_t *ptep)
> > to be used in exactly situations like this? With that the semantics of
> > hw_pte_t pointers becomes straightforward and closes the still ongoing
> > "storage vs lifetime" discussion:
> > 
> > hw_pte_t*     points to HW-formatted page table entries
> > 
> > ptep_get()    is used to obtain HW-linked/attached entries, and may wire
> >               extra code like [1] or [2]
> > 
> > ptep_get_sw() is used to obtain HW-unlinked/unattached entries and in
> >               most cases is just a direct dereference
> ptep_get_sw() or ptep_get_deref() is better name here?

ptep_deref() would be it.

Do you agree to the suggested API requirements?

> I thought __pte_from_hw() is ugly enough that if someone tries to use it
> wrongly, it'll be noticed pretty easily. I'm fine with any other name.

The name may be not perfect, but it is the way it is used above looks
wrong to me.

> > The caller should always know whether the entry is attached or not, so
> > confusions like [3] are avoided.
> > 
> > 1. https://lore.kernel.org/linux-mm/20260526-kpkeys-v8-21-eaaacdacc67c@arm.com/
> > 2. https://lore.kernel.org/linux-s390/650903a4-0dd9-4e6b-9d4b-3c32c5657236-agordeev@linux.ibm.com/
> > 3. https://lore.kernel.org/linux-s390/b44e071d-7c9d-4e7e-a84d-4af3499a5a05@arm.com/
> > 
> >>  #endif
> >>  }

Thanks!

> -- 
> Thanks,
> Usama
> 
