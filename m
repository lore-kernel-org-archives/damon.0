Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02625EBC
	for <damon@lists.linux.dev>; Fri, 16 Jun 2023 06:54:56 +0000 (UTC)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G6qYUn009415;
	Fri, 16 Jun 2023 06:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=ylpp8rVbCG3anuIAyQa0P54lzsBpT7c9Zj+0rAXu3xQ=;
 b=hybYbIEY9E3zgMiO9iDWZRDpRSWqddRF2KqERRThC8782/93fbQei7gZjAMmNAVspe4O
 L/q4hcLwXjOUbw9iskPfSJPlGmyZACEYULYZrKRYDuV1NcodqNEkGACengVcRvA7AmPk
 TVqYjLNU66K5GBRDU9DfO8RCsU0CCOMSNaFlHwAsQ4wCX3jsoedPMt+1kECw4D6XDfDk
 dImE+XgyLrBndAz+XzjQTaOoeTBC8u6uzgcwdiXOXu63tYixkW2DYZchFHtLn0nVuj8F
 iuKpFGalj37xG1uanzgTEMqf9K7TEIpGmf15DoIiyilO4L2MenlZddChlJqjM9CQ1KJ8 nw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8juu80v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jun 2023 06:54:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35G6MaRu009776;
	Fri, 16 Jun 2023 06:54:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt54705-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jun 2023 06:54:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35G6sb1V11862540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 06:54:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 491CF20040;
	Fri, 16 Jun 2023 06:54:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2CB420043;
	Fri, 16 Jun 2023 06:54:35 +0000 (GMT)
Received: from li-7e025c4c-278d-11b2-a85c-da661cef46c1.ibm.com (unknown [9.171.13.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Jun 2023 06:54:35 +0000 (GMT)
From: Piyush Sachdeva <piyushs@linux.vnet.ibm.com>
To: SeongJae Park <sj@kernel.org>
Cc: sjpark@amazon.de, damon@lists.linux.dev, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: DAMON testing and benchmarking
In-Reply-To: <20230614172700.82480-1-sj@kernel.org>
References: <20230614172700.82480-1-sj@kernel.org>
Date: Fri, 16 Jun 2023 12:22:50 +0530
Message-ID: <87352r6gql.fsf@li-7e025c4c-278d-11b2-a85c-da661cef46c1.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SarKVKgM3jkO7g9xGS838EvyhLNGw15e
X-Proofpoint-ORIG-GUID: SarKVKgM3jkO7g9xGS838EvyhLNGw15e
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_03,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 clxscore=1011 bulkscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160057

Dear SeongJae Park,

SeongJae Park <sj@kernel.org> writes:

> Hi Piyush,
>
> On Tue, 13 Jun 2023 12:18:48 +0530 Piyush Sachdeva <piyushs@linux.ibm.com> wrote:
>
>> Dear Mr. SeongJae Park,
>> I hope this email finds you well.
>
> It did, thank you for this email :)
>
>> 
>> For the last few months, I have been looking at DAMON from an end-users
>> perspective and a developer's PoV. Most recently, I was focusing on
>> `lru_sort.c` module that uses the `lru_prio` and `lru_deprio` operations
>> which result in a more precise reclaim. In my understanding, enabling
>> the "lru_sort.c" module would make intelligent decisions based on the
>> access frequency of the pages and end up preventing hot page
>> swaps. Hence, when integrated with an LRU algorithm, it should improve
>> it.
>> 
>> If you could share any test/benchmark that you might have run to verify
>> the above assumption?
>
> Yes, of course.  I will share those soon.
>
>> I did find the result numbers you posted (link below), but that doesn't
>> mention the "plrus-*" scheme numbers. It also doesn't have numbers for
>> running the `pageout` operation on the entire physical address space (paddr)
>> i.e. the `pprcl` scheme. So, if you can link those too, it would be amazing.
>
> We run an automated test[1] every day, against the latest damon/next tree.  And
> the page you linked is the output of the test.  The latet version contains the
> results from `pprcl`[2] and `plrus`[3], but I was too lazy at updating the
> document, sorry.  I will try to clean up the mess as soon as possible.
>
>> 
>> Can you also share any real-world (memory-management specific) workload
>> results that you would have used with DAMON in your experiments? Like
>> either MongoDB or memcached over Parsec3.0 (including splash2x) - which,
>> in my understanding, is less memory intensive and more architecture
>> inclined.
>
> On my personal testing setup, I'm using only parsec3 and splash2x at the
> moment.  We heard some production DB system is using DAMON_RECLAIM and achieved
> about 20% memory footprint reduction, though.
>

Are you aware of the specifications of the DB system that you are
mentioning? 20% is an amazing number and if possible I would like to
know more about the details of the workload.

>> 
>> I also had a question regarding schemes - A scheme is highly tweakable,
>> and it's what the efficiency of DAMON rests upon. The more precise the
>> scheme, the more efficient DAMON will be. Hence, I'd be thankful if you
>> can help me derive a config that would provide the best results.
>
> Very good point.  Unfortunately, repeats of experience and adjustment is the
> only way as of now, like other tuning practices.  Nevertheless, DAMOS supports
> some safeguards such as quotas[4], watermarks[5], and filters[6].  Because
> quotas feature provides prioritization, setting the access pattern a little
> wide, and more focusing on tuning of the quotas might be a good practice.
>
> I'm trying to add some more easy-to-use intuitive tuning knobs, including
> feedback-based quota auto-tuning, which I shared the rough idea at LSFMM[7].
>

I did go through your presentation and the summary article on lwn.net .
The feedback-mechanism based self-tuning does sound ingriguing and
promising to me.

>> Hope to hear from you soon.
>
> Thank you again for this great questions.  Please feel free to ask any question
> or helps :)
>
> [1] https://github.com/awslabs/damon-tests/blob/next/perf/full_run.sh
> [2] https://github.com/awslabs/damon-tests/blob/next/perf/schemes/pdarc_v4_2_2.json
> [3] https://github.com/awslabs/damon-tests/blob/next/perf/schemes/plrus-2.json
> [4] https://www.kernel.org/doc/html/next/mm/damon/design.html#quotas
> [5] https://www.kernel.org/doc/html/next/mm/damon/design.html#watermarks
> [6] https://www.kernel.org/doc/html/next/mm/damon/design.html#filters
> [7] https://lwn.net/Articles/931769/
>
>
> Thanks,
> SJ
>
>> 
>> Test results: https://damonitor.github.io/test/result/perf/latest/html/
>> 
>> --
>> Regards,
>> Piyush Sachdeva
>>

Thank you for the information and all the links. 

--
Regards,
Piyush Sachdeva
