Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B35402422
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410813; cv=none; b=JEzy2ZlQL+X8KL+IAU+zjEchRuASozKG2l6qPyCjdkF2ISlOrC0L7obOGYivIl67rhW/p5pYyrMwlbH+BcJ2FaRDLBu1NDIYQ++XfZQHtoRSPnx/odwmDEBpfr55cJQS2LRZBPIzpL5+uuDPk+YqcSpE5OZ89wKY71+X9douBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410813; c=relaxed/simple;
	bh=Ordl6f/X04svcxMHWSCWOflstcT1JzESUuFhn2WQQXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW4quEctPv/z6MhTlpbmptm8zVwfIavYGbXHCXmSJpKhc1kRIqEbqLnY7lw1ZFmwyA053uswFSY8gX/WUG9zKSnWvv6Vh8ATJVuYzCIbQ2XInfah88MKQKWtfAb7Nyws2el4JO+ZN3hxnenO5nd/Uq38WWSpX3DlbJboOdckZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sdfyMp4a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sdfyMp4a"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAITVb847877;
	Thu, 30 Jul 2026 11:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rL8DGprZq6+UDaUDPLLoQG6SRBTZ0q
	XJevfXG66EoPI=; b=sdfyMp4aCvxroURx10Xqk4j4EkRzqRZj/d8ZEbHlZbxnsv
	RZqWLEeKsnBJxY69g9Rf/enfbEgMoW9zjk0DqTtqb4SdiKe5h4FUE02bCamE3eNw
	mKXSoos8tPzO8X1IdyqwB4WqK1lJ405Tk6jCGPxj7zmKeqFvuP5hapmXPKq+fUfo
	8c0EfX/h24wizj+fNqRoZz8PEn83J9Xe0L+2oOSO33qjTAG88+cOpPBcZxQ2MryQ
	9C9mVFf4A9AmKDd7qse+ZJEv879U3qPaL/p4pQJCMTWhoECKTBGwKSFXpWa8LXuD
	llCRCK3hTVvsG8xNe3CL6OnYTma2hyk1ExuGlNOQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycqb5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:26:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBQHmm004385;
	Thu, 30 Jul 2026 11:26:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yashv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:26:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UBQEwm32309740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 11:26:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899DD20043;
	Thu, 30 Jul 2026 11:26:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9B7220040;
	Thu, 30 Jul 2026 11:26:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 11:26:13 +0000 (GMT)
Date: Thu, 30 Jul 2026 13:26:12 +0200
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
Subject: Re: [PATCH RFC 06/11] mm/kasan: use hw_pte_t for the early shadow
 PTE table
Message-ID: <e3bca247-0644-48ac-96c0-ea69b23cb11f-agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-7-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727164715.2866609-7-usama.anjum@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1yShbzchCRrZFjJxcUOHA7XWBBHN_PSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4NCBTYWx0ZWRfX0SdyyNoCDIst
 tiHB2CaM4QF1p8CCtTiYaSOOUgx4+BDwgoYVCM0LTdDbXgHT8/B9naW6e8rzhr56cn7hR9Fzc8c
 nPSzjrwIAfuvIaxWPqmH1yuIdMBpPPVn7Mn8EFWyE6rfbbn+KvZsPAt18g3Nj8TiN9asBygXzqs
 MOcTiWGHpo4+SRwQXAgcLc5Ck+v9IcLezDKsRLpXQF/J9FIBl914ZpgcpDnWSHfrF6KVdFhG4e9
 BSjq1WFCWKAjaX66X5eNxr+WT0s1DTdNLA6Hzh85YA3Dnk5YTz7bRMivBjHJzA4JetfKwGfrowF
 1Y1bP2dyFTwDBK2ZMETXXXHgd/POo9dvPpDqYXuvTey+LmDZzsFpAInoRRAQYp6bwuUtGBPAzc4
 IsGzjJX/oyASB3D1gl37Ts2dTvivrw8E1t1YVsgaA7enYVurHpIBKWJ79PpxWuTkCeUmhZS4op6
 BD6hW/u22g3Iijfgkdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4NCBTYWx0ZWRfXyS66madxJqQ1
 YcsQPbiIkHTtCPcppu01CqajpxI61cieuOzVbuUC/F/5np1ISiVjCoiBD39pyHxQ6W0rgkTduw/
 oTeLAP0IBqNIKuWWs0UjDsrPcoo1qJE=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6b34da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=8mY-gRJjsCn2C85XUSAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1yShbzchCRrZFjJxcUOHA7XWBBHN_PSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300084

On Mon, Jul 27, 2026 at 05:46:57PM +0100, Muhammad Usama Anjum wrote:
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 376880071ca2a..8f19f20be3c44 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -19,7 +19,7 @@ static inline int note_kasan_page_table(struct mm_walk *walk,
>  {
>  	struct ptdump_state *st = walk->private;
>  
> -	st->note_page_pte(st, addr, kasan_early_shadow_pte[0]);
> +	st->note_page_pte(st, addr, ptep_get(kasan_early_shadow_pte));
>  
>  	walk->action = ACTION_CONTINUE;

I suppose this chunk could be posted as a follow-up to commit c33c794828f2
("mm: ptep_get() conversion") independent of this series.
