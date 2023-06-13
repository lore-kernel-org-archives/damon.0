Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE591844
	for <damon@lists.linux.dev>; Tue, 13 Jun 2023 06:49:07 +0000 (UTC)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D6kFRI027368;
	Tue, 13 Jun 2023 06:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=gmG6z0AdC2J3asvww+4weYo/FbTqpbQY75lclW4dW5U=;
 b=nto1vGxCV/1509gKv0IuwXiaH9KoEIn/AuC1/ucd2yi/t493U6dMjPQ9FD94jO9NcXFy
 AMFdKrDCCunnwaE6Y45TqOj+/fvNOA50YXOwDmZ1ko3xKVzxDA9RPWC73OfGS2W7l8R1
 4vlpaP2UhMr/9jXO+1rwSxMWRNVq47i6tQD9f8Ad012w/cgA0qQfkUWD4ky0lDxxarjA
 JkrwvS/nvWqFgGfydXPfqboDrJx73lUrrtvydLsJjQL0qkzy6pA0svy78ueOcLmWny7R
 DSXSK99XFbgNAPrvYgXUohWdWsM8KBpOQbe2Djd9b5K69pNC2cFBCDfYEuOpQt3ibRQw 6Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6k0rgk9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jun 2023 06:48:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D4rEvu017859;
	Tue, 13 Jun 2023 06:48:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt51y2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jun 2023 06:48:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35D6mocb18285256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jun 2023 06:48:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BB5620049;
	Tue, 13 Jun 2023 06:48:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 643B920040;
	Tue, 13 Jun 2023 06:48:49 +0000 (GMT)
Received: from [9.109.218.210] (unknown [9.109.218.210])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jun 2023 06:48:49 +0000 (GMT)
Message-ID: <e6e8c252-f7b4-e71f-0315-f6cc774354d2@linux.ibm.com>
Date: Tue, 13 Jun 2023 12:18:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: sjpark@amazon.de, damon@lists.linux.dev
Cc: linux-mm@kvack.org, aneesh.kumar@linux.ibm.com
From: Piyush Sachdeva <piyushs@linux.ibm.com>
Subject: DAMON testing and benchmarking
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PhxerfucwcE4aUzYIjSfEZV4N9KaVk59
X-Proofpoint-ORIG-GUID: PhxerfucwcE4aUzYIjSfEZV4N9KaVk59
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=773 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130058

Dear Mr. SeongJae Park,
I hope this email finds you well.

For the last few months, I have been looking at DAMON from an end-users
perspective and a developer's PoV. Most recently, I was focusing on
`lru_sort.c` module that uses the `lru_prio` and `lru_deprio` operations
which result in a more precise reclaim. In my understanding, enabling
the "lru_sort.c" module would make intelligent decisions based on the
access frequency of the pages and end up preventing hot page
swaps. Hence, when integrated with an LRU algorithm, it should improve
it.

If you could share any test/benchmark that you might have run to verify
the above assumption? I did find the result numbers you posted (link
below), but that doesn't mention the "plrus-*" scheme numbers. It also
doesn't have numbers for running the `pageout` operation on the entire
physical address space (paddr) i.e. the `pprcl` scheme. So, if you can
link those too, it would be amazing.

Can you also share any real-world (memory-management specific) workload
results that you would have used with DAMON in your experiments? Like
either MongoDB or memcached over Parsec3.0 (including splash2x) - which,
in my understanding, is less memory intensive and more architecture
inclined.

I also had a question regarding schemes - A scheme is highly tweakable,
and it's what the efficiency of DAMON rests upon. The more precise the
scheme, the more efficient DAMON will be. Hence, I'd be thankful if you
can help me derive a config that would provide the best results.
Hope to hear from you soon.

Test results: https://damonitor.github.io/test/result/perf/latest/html/

--
Regards,
Piyush Sachdeva
