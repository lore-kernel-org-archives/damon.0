Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D12339B3C
	for <damon@lists.linux.dev>; Mon, 10 Nov 2025 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813483; cv=fail; b=eUBvJs3iX9Qwq6+FTQ9nKja4EC9gkLIBTg0GR8fqD3rIwsc3Dvww+9IEVC/L3syMS8qNh8Q+c8arrp3lVmWBn0gPQpk4camQhjoCzUTPge55QF/mhS5ISZUqXOuSUWZf4bharcHb7hMnR9knIi2o4k08VQpkyFp2jv3RXrzWZrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813483; c=relaxed/simple;
	bh=YcD+GAQas06zV4qINaiJ3vQNtxAzNbXRFqpA6xJz9gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lqoTStK5pAlnzjvajsNpFPUaLm6WXvK0/OsgGZkslrDGbHqJlNU7y8f2Wc3BJZUV0Qsuz+WxanCFgJDt9uJZI5cJQc8eQwZ6yJpaAtz7Q2Jqq3uTwLswaBnBDh9mZn2QevHIOUi73E1P2lDvYfBNkYE/MgbaFBeBGFAVIElZ13w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WfONE62o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YJdbuRiq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WfONE62o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YJdbuRiq"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMFiDR006626;
	Mon, 10 Nov 2025 22:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YcD+GAQas06zV4qINa
	iJ3vQNtxAzNbXRFqpA6xJz9gk=; b=WfONE62oID03O2osNrkKV+gohaM+jFqBCj
	MZxC6nHrpdq/bToOG7qCCPnpvaIye69Lzi0TAjHbNGBKSFwdxK3pfWBPm47AORwQ
	yv2y4lDPsfQoWUC8M2+mviQiO32rS99erOWXTHSbglikXT7O4mwgMikFturftZqB
	0bhC036NvnC4YmGpHnCjcDjF3wwKsPrQk4w1EurfZqaucJXZBSDxLavsZSemuDVk
	jSS2XBnkMB8ZJjrcufDPmbOgmW2zp+q8JB1xi15guyFMLEbir0X2zOtCkXAIwr1h
	ZZ3KhoWCCtCKkUquwRQrifZDg2fYvZRAyB6w+mwozaSHoJtQeurg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abrpb814h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:24:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALn4X4039990;
	Mon, 10 Nov 2025 22:24:26 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8s209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:24:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBZ18YGHUJ9MCVBxBGj06gcnSInX5N8Dm9sJPbPz/B3RgJ9Cv91HwEKW2LmuMDD7EO+IM5csFrg1X0nNHRIJPrRs8kKBJH+nYL5wdVOaEZIRsLy/p/jqVbV4nw5TgthBT00WwM0SOpfMwWJXnaRWeQWw7qZ4eKGU+j+WlqhY9+wPFx8VM76TnocMnZML/n0Q9OQ1otJBfkMkrHmJ8XjwiF/Y6g6AgOU9lbwwIehf/1w7HIgprlEp5s3hniaEimBnJGiDX/UxCVCDK6Bh9TcMq6YvfNp6SLCJyyJl2/3fXrztqn5QjQYNsbGJitvTaal229N0gQW8frHh9LbMJmIpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcD+GAQas06zV4qINaiJ3vQNtxAzNbXRFqpA6xJz9gk=;
 b=pm9iB4KS3+/PEu8cYs9EgFBqSYB+IYY8xjeca9tc0oaaPnkuxn3HUE/+Wcugdyrn/7c+N/DMaRGeQzDU2y7oIALpOcWSl3kK2AmntHXqMJIdvHuoYq0L8GHgp5yeOpP3IDP6bKxLkGcNmeaD6OvU2k7cOhTMCBniJp7XgwSuE03nYsVnb9XRRv66I73TAgNnt8ue/p0CaU5FPb2y6Ouso5u5fXYLoUa8NftXVkFTEhsJcldUveKzZqCoG8b8QHfxE6xlHeqHhgLuEfBHX1J2jun/xbZa0KlwqTzBOsuC5ve6YtUkseizQhqb5P0X4QDQMPMbcSUYw5vjhaX7u86rWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcD+GAQas06zV4qINaiJ3vQNtxAzNbXRFqpA6xJz9gk=;
 b=YJdbuRiq9/G/wdGBnHy9MdhK99wmN4GRNMVuwtQAB8saITPFQCAvOFHlsmOJtEo76ApqKToHHPZV2+Rtsmk/QPUDz6fzrrxwaN0sUgANroMEWR1FKLa0+hcM4Tw/zaUzs0g66rs+1qo+EZ3fjWZJhjKm5fEV6DBm9pZCQzgRHRc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:24:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:24:21 +0000
Date: Mon, 10 Nov 2025 22:24:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <4f87d5b6-ff26-4e42-82c4-88256e253a5f@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO6P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: c20394ee-0867-464b-0b00-08de20a7e535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JdOMAORu/nt6VTK+ab6bij5q1xxbc0S3eYhOrvjfqB4iKqYOPGu3x3IHsjwC?=
 =?us-ascii?Q?BCcN1F4a+jOhqvvJGYxD9R9Q5a0sa/bMqFvoBXgjnpX4+7nsrxr6YKCQZTTc?=
 =?us-ascii?Q?BNp9nGhzDTegK074VEuVXgYaE0BcmYgyeIJzMEtGkFdpUGH/maDkQhpApJNJ?=
 =?us-ascii?Q?5n9O9FHQOgbSg5wnBBAwGgdrrHSQgaE3E9NaZ/jI8UW2kFSIOlbtbipM1oK6?=
 =?us-ascii?Q?P7ayb9wTA+sywUZ6Y0df3ktiGJx3Psa1RC8j7jLc6QFlDIhhMPdbJ398g7fn?=
 =?us-ascii?Q?z0sSMmODuKxQt1O6cHlMp739ELwqemAWTe4MseQsmlwxcpD8Mg7WGZ+evNPZ?=
 =?us-ascii?Q?7j23IhN/1BrjnI2/Dqk/UnkEWeeY7BjujS9nEgGJlLxveRpofdnCVk8Arc4Y?=
 =?us-ascii?Q?4JEIRhV3wRLIimJb+mFWgktQMjp1JGNvEo24MG+VN3AWDppseI7XD0TA7zif?=
 =?us-ascii?Q?0rwL7riFErMS5bYgCXAIWz3WvKaM0o16HkNAc+iWDJ2Qb08G4lAu7ocHYZ4d?=
 =?us-ascii?Q?4uhXOvSBkSyyxPZispV7sQJbL4mQI9xIbqH0+TiSyWwThLyEXLQqzd/D/u79?=
 =?us-ascii?Q?5scL2ftu9LgsWuWG65OJSLEIqpMtgh+Bb57ERpVzobn/iZNoUCm8o+/v2fbT?=
 =?us-ascii?Q?PizIfOOKVlxN/BPsrvhorIIS6oSvsKLBUVu+ltCa9mTFmE2U0ofn11d5RXOY?=
 =?us-ascii?Q?mTxwD7dth1qd+ItI93jtVQvv/G4r9GqW2mXCc9RsNQBVh7SX7WyfiERjP302?=
 =?us-ascii?Q?xbE2IQzsKe6xm83I9VcburAlMv4ZOsldaFmTYVtBgod++3ecsQZS3Xl/rGp3?=
 =?us-ascii?Q?h24X1C0kJQohp81+TWsmop9ZvqEoD7fGgosrDlK1Hzjte+pU050+blmBaH2g?=
 =?us-ascii?Q?N7B9BJg2vwsGvMwrRP6ZteXyn4YAi/XU0m6SsszPAKeZ2Bi+i2rCH3Aqd7lj?=
 =?us-ascii?Q?aDE9iGs3OJjJXmNFPorBgB1h8/BJq51orKQCXNLhvDgxjMbsApYqkmrKfMbi?=
 =?us-ascii?Q?LrD6QqFBpk2xqkWjuitnHwqv949vUhIfiwLIblqOjU5GEdWPRVcNsVY+GVc5?=
 =?us-ascii?Q?iJodsdk93wbtlQyoBaEvUvsbWA8QJUIdoN54GhW6m6Tj/S99yePjTvwY6pjJ?=
 =?us-ascii?Q?JH4TljMIKUR7I3YB0/+GpG/G9EcL8LbOsPUHYaOoGTL9V6+YK8F2yi4HoR1V?=
 =?us-ascii?Q?CvN+l6ve2cSOFqlUp60TDyBUH7BUfk0lPgPDfRW7k9oymcig+5T1NNu077ot?=
 =?us-ascii?Q?68p1KHr2AQhTeMXAps6LMkFcJw/ymeCVbv7ki7J2SKtpL+jz1gzhnMWz/Szg?=
 =?us-ascii?Q?FUbDuwAjz2jNTr+vnwsebLqtSAs7j2xfcBozt03ZI8LoQoVALQF4xefvh1l4?=
 =?us-ascii?Q?wQPVnLidOFkuBAs+LR+tMv5ih1azHYre1BOpn8hSUw3RBZ31eAMq0iuDW64O?=
 =?us-ascii?Q?oMpjmmg//IS112/qQDV18/gacxi31dVF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1QH/sPQhg4RL8l6bu45/Ejg96dqFiKhjfGcOy0yAea1a/J96nGHUAtp7rZlW?=
 =?us-ascii?Q?Vw03uxPlLAsY7uKIwLiRNyJjgvautMH7xWBv70JtbzTvLbDB6T3FLS5o0qzz?=
 =?us-ascii?Q?mea82sh8az4qcYKfATFIf7rrGKdvr9pmRNHnQInB42HhS9qUNKv8i/V6EWDw?=
 =?us-ascii?Q?Nqxv/KA7mrCrRmPMJWJBmDnKUBxKqDotQp0VcJhjtXroWOEnCMPZbguGCBzu?=
 =?us-ascii?Q?OPZMJpNnsXGG+TLBSxCV9pZSEMlhpxG4xL6YNC/ouERLRsTxCHP4WfJgFajC?=
 =?us-ascii?Q?MddOygZko+bUdxaeQbZnr5pdW4lC+al1VqdJJqrxE/PvZyTqSPco8rRDf60h?=
 =?us-ascii?Q?x2yG4+YXEfBJiXC/lWFoYlImRlQDh8snw/P8HORq4FYTuRuWSxPU6tLq60uM?=
 =?us-ascii?Q?oybMcq/6PMSGGcvsKbhtdbSvaqwwV6kC+TJDw5JHeZPVxGLPRw6GA7iVCvt8?=
 =?us-ascii?Q?XyvtNDlq/6zIx5RSh1wVF9DBMMOWEDCEFHpV4O3e0CPMx3VXLPnXmZRqd2hn?=
 =?us-ascii?Q?4qIIfwDxJVM1IY8E64i9QCc67x+wrHSfm4YNHxKcx3BCwZ2KPhz6rTDfMR1q?=
 =?us-ascii?Q?PEGsxSSkm2W52yjruFh3OmXRXVyxhDN+kSDekL5tZQ8Rs2GGSJn9jmKZ2zpt?=
 =?us-ascii?Q?oiAi3SAx1fyNxL8w/Kkpc9TANfso8SriCHrdqk5gyKDKCEjTnZKZEj46gf3i?=
 =?us-ascii?Q?YxuTk7crLr0rB9BdOD1XVwvxTqRAsVbnNKSTOwzhlCmLjhK4DA3THVWC8yP5?=
 =?us-ascii?Q?den6C8QJOpRXXpatWwTg3MLDRnukX8fu5umWcOZxGzNVAFGzqvjwNCCE+8nh?=
 =?us-ascii?Q?ij8HnlFevyJYuZ5sRzT6YMb2qYi5s7FmxEd5FIUCYdVQyzh1WU7RU2xUYDlw?=
 =?us-ascii?Q?v2dNyve1+nfMHoGtY7QwjU+U3M/urnWmVAbslgLKNGeiYRKrJWzXcxdvw/ZI?=
 =?us-ascii?Q?l7ithUIh0H6M23rK6M6sSkR0NTowEc6er2f/swMEgG2QVSy0QjwKGd8bdeUc?=
 =?us-ascii?Q?BDxrcqfehexN6xtLOZBjH72GzxDb7gzYp8LGBooIHfaqS+k7rIr89tavk63Y?=
 =?us-ascii?Q?xQ9J14AWYCQ3SsryjzjrVJyvy5+eK6TECvXHJ09qANH0QV7z0odmq3KeeG1l?=
 =?us-ascii?Q?rOEy+uTw/wBJLoNHqqYhOvKrcb+2xHGajzV/3MNxvLyDlW9aCKfWyGGcvRh0?=
 =?us-ascii?Q?why4ECGDeHSFheTrerLNMv414BqTu6iFA8kpO9Qq1/ow/+b8H/sL9XDy/Q/z?=
 =?us-ascii?Q?pMSAuwZqIJ/d1LKMaM0jzYI54JWjBj8gDaXbjBr9y/OnxMj/lzz5QNvvpTE6?=
 =?us-ascii?Q?1y8xOa3/Y4d6Fn7KGx7CI38jnBGwHSI2MpJ1yQIw1FKomkrGlqa7w0XZ/bJJ?=
 =?us-ascii?Q?rjNygJmzL1W28T1poIRyIU6EwZ43A2KGDMc+hwM3A0mjRQH1GShzz3KcMycY?=
 =?us-ascii?Q?IcOJBkch+Wk8EeMtuw0BguTLDos9dzaGSpfCAfB6MUwfZPl9GoPvZSHm0XjB?=
 =?us-ascii?Q?xW1RP1TZNTqurg0uBOVVcHUfcl8Y5/9+eoNhV9cyeC6cGq6y2bxRr0jcUMOV?=
 =?us-ascii?Q?lozYM8kg6FjptW1vK9sh8LPbXR2xA/VVpacwFAzGnWSdu5BGwX4pON5uXSSg?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RYopisQtGEmyAR1RKcgDc/mKVfYCWG7ivuPAJxraqxINkj2mcEsTLoHZu/85x6psSKFGkFk/X02c6Hz5neGJ+8pznIJPVuX0nazpa0gG4fG9OdroYZrqa0DA3efrk4iRJJnsbztenD4XLO5oh/Mw9jRU67S143oMyLbDJzf67PeCpV1jMO5k7E/FieiRvjxdswJfl0sJ6DXNJUqv0hOHWsQBTtFL145VNdtcoghaM0vZ2F4Flt+UhsXZz04nBrB+vZqsqBOKhutHq7Puqe4vNUyU66GNz75bWV5ak2aBDXYTZaekbrwaYwX0iI3bxWATrLOhEyzLi7bHFCYVC/Sp9igPtdh3Fn+mSkSLZgRoXchfjKoB3D0MwS2iZgM8stLkTi7J05rX/0DkRB2Cbgpx0bfieZ9fnAyHI/m8u/nQu5j/Nf+uOio59NKj/bWtHIZJlBxTppR3o3Eu/O1KpGdAnj5ZgVSUDA+FvECQOzfFMkeqRvmZE+ujOIV/OYWgW24ZZXjhtUVO+5SKElQ8zBL/DFU6nkSkxQaL7lgYEjKvf3vz+0LSEn6sp2yWjtDjFVnv6U3SHspMuEay+ltgMKXkGiWYtyYjaCLyo02ifSGTcJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20394ee-0867-464b-0b00-08de20a7e535
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:24:21.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW7H5aLw4SbmcpFmqyeS7zQgfyMwwrXRy8ryCqF/RN8euGaQ+i+YejwwMs3vW9sTOtI8EuzA7QvP+4y3PtVxcmPHIUEdXt1bMPk4D7tmo6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=832 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100191
X-Proofpoint-GUID: xiQv_wrTv7SI645jXwAi5bM7-ZlU6KYO
X-Proofpoint-ORIG-GUID: xiQv_wrTv7SI645jXwAi5bM7-ZlU6KYO
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=6912661b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=msyUSSKfDQgGK_7RJ1kA:9 a=CjuIK1q_8ugA:10 a=UzISIztuOb4A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4OSBTYWx0ZWRfX/owhBmAfmJfB
 FNVJKvXtTrWyVHlM+bTIAVVw4fND9NSeAFVay8IIO9OcsoI3FS9rA4gk8F9ViCMGE42GY66ipVW
 HdjaoBwbQRX17DuKKOW2yP0JHDuEbmNCttq3JUqZs1LZSCzDx1p2xxhymY2pIbRx8NK/czqUKTu
 tyn9KOy1xJ9MuWpCd0YtaHN830NPmPq9LPZoSMQHoJiSLuFlP0X78tLqrH/00YsDGaofzqbzAQw
 /t1t4Iar9IeEgAl/oVbEYc/hWoskNEDwQhc5M5dIJYcxSsAPJ0UhBwhDsLxQBunRotAurNRx2Ih
 UDvcGbEFp2f464+FR3FF+gYOoZW/Ikpl7+EWpSCSNOJmxp+hPceUrs8dRExBrLJMfDOIfami0gj
 P3fkxthdG7NsChaC+V9CkMLlGQa+GA==

Of course sending this late I acccidentally labelled this cover letter
'v2', it is in fact 'v3' :) Doh!

Cheers, Lorenzo
