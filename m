Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8A653
	for <damon@lists.linux.dev>; Sun, 19 Feb 2023 14:30:18 +0000 (UTC)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31JD412d015451;
	Sun, 19 Feb 2023 14:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=EGZ7SSY0qGjJ4cAo8CM8G6U/1RpqPcXqK25mec2kdEc=;
 b=nU0xzuO77EzOmbHxhPE1vM4aOqdymf1wn++QmiY/nQ2xou++bR45sN2dIBOStOfb6Gff
 SYANwRomaymuknJxSczZp5r2Y1tMQAVKrTckSP88w0pZf2juSdQekNgsFI+mAiNT/p0Y
 MQohd2RV+IOqTlCnA02yEV0bI7zMY6uS0p4Viu7O5ROekHS9IpGh0Jc1PgNFmkEPI2pE
 8yKurxK3jSTAPu2Uwc9+YdddYcB+A5xNSiat44Z1ikLzA7LPyJPgsfZu7yYoy0nVFlJG
 290ElEwVTiMLMM/5ijduQmJ8WkzQxR1ze8zEZQ8vV5oP8ER6uncKEQfqEPN66XKJyD/p tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nu8u1u2xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Feb 2023 14:29:56 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31JETuX1032696;
	Sun, 19 Feb 2023 14:29:56 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nu8u1u2xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Feb 2023 14:29:56 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JDTgOO003465;
	Sun, 19 Feb 2023 14:29:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
	by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ntpa71wax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Feb 2023 14:29:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31JETruq40567174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Feb 2023 14:29:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5706958058;
	Sun, 19 Feb 2023 14:29:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9704958057;
	Sun, 19 Feb 2023 14:29:50 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.112.244])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Feb 2023 14:29:50 +0000 (GMT)
X-Mailer: emacs 29.0.60 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
        Yu Zhao <yuzhao@google.com>, Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, damon@lists.linux.dev
Subject: Re: [LSF/MM/BPF TOPIC] Using hardware counters to determine
 hot/cold pages
In-Reply-To: <20230217164211.59619-1-sj@kernel.org>
References: <20230217164211.59619-1-sj@kernel.org>
Date: Sun, 19 Feb 2023 19:59:47 +0530
Message-ID: <87fsb1g23o.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Oz75dMC7TR3xyQpi6Cxo2FtnEWEUPG3
X-Proofpoint-GUID: lLrsprXF-09XrlSEYUoHAb2KnLeREY9y
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-19_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302190132

SeongJae Park <sj@kernel.org> writes:

> Hi Aneesh,
>
> On Fri, 17 Feb 2023 17:28:09 +0530 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:
>
>> PowerPC architecture (POWER10) supports a Hot/Cold page tracking
>> facility that provides access counter and access affinity details at
>> configurable page size granularity [1]. I have been looking at using
>> this counter in different areas of the kernel such as
>> 
>> 1) Page reclaim/demotion
>> 2) THP utilization
>> 3) Page promotion.
>> 
>> I have done some MGLRU integration and would like to discuss the
>> observation with the rest of the community. It is still not clear what
>> are the best ways to integrate these hardware counters in the Linux
>> kernel.
>
> Sounds very interesting.  I think DAMON might be one another option, because it
> is designed to be easy to extended with various source of access
> information[1], and provides an abstraction layer for access temparature based
> memory management[2], namely Data Access Monitoring-based Operation Schemes
> (DAMOS).
>
>> Attached is the performance graph showing how the mongodb/ycsb
>> benchmark performs when using hardware counters with MGLRU aging. An
>> early RFC version of the code can be found at
>> https://github.com/kvaneesh/linux/commit/b472e2c8080823bb4114c286270aea3e18ffe221
>> . I also expect we can get some numbers w.r.t THP usage before the
>> conference.
>
> I also have experimented a DAMON-based THP optimization[3], which shown
> interesting results.
>
> Hope to discuss about this with you at LSF/MM.  FYI, I also proposed an LSF/MM
> topic for DAMON[4].
>
> [1] https://docs.kernel.org/mm/damon/design.html#configurable-layers
> [2] https://docs.kernel.org/mm/damon/api.html#c.damos
> [3] https://www.amazon.science/publications/daos-data-access-aware-operating-system
> [4] https://lore.kernel.org/damon/20230214003328.55285-1-sj@kernel.org/
>
>

The hardware counters that are supported in the case of POWER10 are
based on physical addresses. The hardware facility will count the access
across a physical address range and there is a counter for each page
that gives the access count and also information about which node did
access the page.

I haven't spent much time studying DAMON so I might be wrong here. The
reason I avoided using DAMON for the POC was because my goal was to
evaluate how the hardware counters measured against the pte reference
bit and I was not sure I could evaluate that using the DAMON action
facility.

I do agree that we could add a layer similar to DAMON_PADDR and expose
the details to userspace. But I was not sure we can take action based on
that. In most cases what I wanted was to move the coldest page in the
Numa node to swap. So that is relative hotness rather than moving a page
that got a hotness value less than 10 to swap even though we can figure
out a way to make the latter similar to the former.


I will look at DAMON and see if that is the best framework for things
like this.

-aneesh
