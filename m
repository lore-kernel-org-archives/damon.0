Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187C3939C1
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574778; cv=fail; b=gg656LxZ936o7nxGW9qJ3S+SonyTA6E8peqk8c9tGxJXX+bRHTxwYobMrSp6f6AsXoHlPidNb6FY+sAszyobQXw648HXu8XwhH0buUE/F1eE3B0Z4YPHLt8RXbqDONp5EzF+1yRKL/uy40QSrsqtTuptsCrmiMshRMkzj9wXCH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574778; c=relaxed/simple;
	bh=kVReo1wxsKBLDu1OlThAekTw7KcI2ER5dM9aO6SrPa4=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=MOuHmd9SQhDfjo1wX/rDhoH8KDBOx/t60WSW+eqldUXxaKEaZD1UVnipQFzUUFOInCrEAzKM/XH9Cvtqgg23MjQrWwnRWgb+MIO4QbcqUjpV5uzF3AUsECuiruI3elhcFcgX+23oJp8vPijk/KYEraIYyHHwYg8z1Bg62accd7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GjJldHT6; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GjJldHT6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8IxTKxKhoY4aYEeefo2ildqncoWJKR3cFvjyNx0W77zb4/Hyu83Z49xkLwjbbu0nWqUzOa4tnIH3GYGdPpxLCRxIM1impjgKNZ6B0Dgp9TZUP1Z5f9MhSnF+X+khxjPPxzaYI7vu0v+WtaCISMLmtdKIClG+AJ+Omlje4QZg0BCr4DBUEhjLVXZKIqvBa8KU/e5lHhruunfYx7n6DPlsLKOrj2pxlt03duOeeQHXg1ecUwlQLMo1uHv3/c4Q6MX2TsA8a7dmBSP3KZGWtOZfkvMV/rRY/kGV34JJt1H1ya7evcH/Mseh8P9L2ErMrL5gGL8D3b7YZppLF0BaQVocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtDhRePc/d/7+vpcQuPWsUKy02vWVLss2qe86idKv9Q=;
 b=GKQgJJRngEbpqmWsoBk2+gE7WcI7UlKjoAfYWxgQSxQT2zrWPlFlSXp/1BzSPcAFMBky0SyP9oBIwWDUPwJ6bPMcR46htWvZ3Gx1xDBLowBOdUTKPBQWARvZqLoQw+5tNgBRLHe0cAwQ3ahMpKJm4jSZr18PXHvGQdkU5edFOGdh7kKaZbuUlWbHQdYBOgY5BuRrK091RAWKbn4BwpEeenjgbneXfFX1mjGA/n7Jae8UlHBIWG+eBbCFlVI0oj9aSkMXki6aaWWT3SaaZ5tANLvSokjvT8vZhLaxJMMWp3YW4Cq27hBGDjL6GmNwJTD2njiawYjahtOFbuJzW0zSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtDhRePc/d/7+vpcQuPWsUKy02vWVLss2qe86idKv9Q=;
 b=GjJldHT6/om6SSY7e22P0CFfglVCWidi7jkHIGPS+FgGakQY8Sp0eZe715bnjsM+7tj3YInrvYve0i4cEy/NmIuQpJmyy+VkGVnJzAR9fwO1W1uBLOKBGvQVFjqWXtrQezoCdcZKKICL1CgmE8Cc6Cy+W5SCXIbspATg9zjozlSrNsbKn36+TnGnaW8Bh8LJKtNxSrLi18fqRZwNBP5Jp6DrWrxntDzUSmhfObyXp+XmY1xOGoOtYg/QKgWDPSX4xwBnJvBUPkn0V4FVfAk9vgk0hLZ8LR93jDNP5RgqsZV2d+0tSEjhY7hNXw72kPOQvjTV7D5TMYawIPjqpx/lkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 19:12:51 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 19:12:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 15:12:50 -0400
Message-Id: <DK3MYJN8KSZ5.1U0STUJGETSJH@nvidia.com>
Cc: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <sj@kernel.org>,
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
 <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
 <npache@redhat.com>, <baolin.wang@linux.alibaba.com>,
 <ryan.roberts@arm.com>, <daichaobing@sangfor.com.cn>,
 <wangkefeng.wang@huawei.com>, <gutierrez.asier@huawei-partners.com>,
 <zengheng4@huawei.com>, <kasong@tencent.com>, <corbet@lwn.net>,
 <skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <lianux.wang@processmission.com>,
 <kunwu.chan@linux.dev>
To: "Lian Wang" <lianux.mm@gmail.com>, <david@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
X-Mailer: aerc 0.21.0
References: <59292ba2-e0cc-4e50-bb26-be9c15843a41@kernel.org>
 <20260720095633.32281-1-lianux.mm@gmail.com>
In-Reply-To: <20260720095633.32281-1-lianux.mm@gmail.com>
X-ClientProxiedBy: MN0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:52f::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b500aee-05e3-42b1-cf9a-08dee692e4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10063799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	rgvhRRLa9ZolsUp5r0voHcWRpkQSXLBNM4WIygbUtvEUfWBrGkWqnrsQYZWqUrxM/ECeoNJDeOgpHWCANUozIoAHapIViHF2FJziyRUXaEcAS/ZlXruTRjGAApSXDhHm4hUK04mvdHxRSuBKmSld3wGBMW6UftgipruGQ5rleVbd5UeIwmfv9Tx2W2nILi7aU/myJ7vHwHxL5HzRkWlZY/QDdUO2wpNUmwhypKBS6kNghYKNb9DARK6Bd72f9VnknFV0Qzb+lTzTme99n3d0SStQ16gXqI9j1CQoKfbfmZwj68ws6JWe+Gsjn3uslAe1vF6iRFPqAMQ8AAeWDK27q9yFNbXeW5kjegLSaWgbQMWdeN7d3+DaEIXl1yYK1xuWSP2ORB/DIE3wG0SMfjFKwFGvpFondyZS/FfrZfhT+63KeNuWYK55kkAEXkB4uPY8rCWnWzihV83L4Ry2f8kUGMiXfLiVc4O77PxFynlUBzmQRCBFeJOnPmqyrJSjYybF4UZfB0VE3CAIOVyRXeSIhRfhLg5sfeFp4REBvXeNYBsnJ4JLm7xDCoPR3JPFZM2rARD9tFwys0gIhSWKlWEtnIdYMVVmQi67gvqQYIfpmt765M8hGqMTre0fxe68Yvg/INRr87Df3VZt3aMH7mbokop86Gv6FyAuEYUYuUwXwn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10063799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WS9JTGFQYXR5SG5qK2JNTTNZeEZEK1ZFb2RtalR2UldHZ0NWUkhkOVdSREJh?=
 =?utf-8?B?Sm04Rk9oYU95dWVlWEVCZFVzRGN0RGUwQXlObjNPcCtkeTNGanBNVTMrdWww?=
 =?utf-8?B?czNrSE9UTnJkV24yNk5ZenZFdnR4Qzg1U3JWa0RsVTZ0ZHpHYXBHRk11NzZE?=
 =?utf-8?B?U0ZTUDhrVlJzLzM2cGhDYXpEQkZSdS9YTHpib1grVk5pSk03b1YvckhGekJD?=
 =?utf-8?B?QnBhZUtGY1NiR25QaENrTERkcVR3b3p4RjZlQXdqblZqMWVEYjVZQlB6eWxM?=
 =?utf-8?B?c29ka2wxODJWQzhsQ2RPdTdlOHNGYXBnTlZEZWJWNGxuVmV0cnhtOHBlMXdp?=
 =?utf-8?B?VVZNa1R1TU1qRFdRTUdROXJ6NmxzZkdEU3Vkdi9jMnBxQk1Za0RiWStxWmxB?=
 =?utf-8?B?MjVPbVBEbzU1MU1naDFyYU5NT2FCVXNZNUVwYmtKR0JKcUhZZDB1MUR6ckh4?=
 =?utf-8?B?WWNHNXpDeUVKSkxWVUhPS2lSa2NwVURGSXEwQXYzclJUaVdHQkRDTHZVdVdU?=
 =?utf-8?B?QTkwV2tPTFBUY2ZNQ21saXJ1YThyYlh1YjdqdnFtU0dsQk1sQWJmU1hZQUIv?=
 =?utf-8?B?ZGM5ZFM3cXlqeFl6Vy9xdFVwS3RrbWI3TlZGT0NBT1NWeUc3NEd3MmluRHJP?=
 =?utf-8?B?djUxUWI2TkJ5NlI4VXRteHpKQlVBbTJ1QktYY1NiSUoyd3BPWWNiRDZrMDVp?=
 =?utf-8?B?WmZyUElMaHF3eVJTTTZOT1J0V2taZU9tSDhYNWJJVHREdzJpUlFMMnh3Z3Jp?=
 =?utf-8?B?ODZET29oYlpxS04xZzdjVCs2N05xWU80V0tiN1ovU1JWQ2hUMm9ja1BPQkM3?=
 =?utf-8?B?RTFLU1FEeUxYUEN4bVM5RnBLZGczZ2hlcmlqNzlXQmNqZ1dPRnJoR1l0UmdT?=
 =?utf-8?B?NHpLYUM4b250SVR4SFZITFg5TDMxLzZ1RUtSWGxFTjJwN0RGRWh1a29TUTlX?=
 =?utf-8?B?bmVXS3BMZDBLVzdBMXQrWCtyWXBoN2xxaWMwaVNMVU5yODByNi9lay9XOWVK?=
 =?utf-8?B?eFV0bGNqMm91dFMydjMzK0ZwMXVoN3FiajY2cWdBbENab2FObThqVnAwamRV?=
 =?utf-8?B?Mjh0bTArYVBKZzZ0T2ltSmpWMXRDWXBoMWg5ZVFOVXZSNUxBbDdnNEt0L1dS?=
 =?utf-8?B?VnJWQTVnNGtoMnpNb1FsNnhFb253UTRlYytoVWQwb2RLdUpqd3duRnhrcVEr?=
 =?utf-8?B?Q2J3dUdJemx4eUdMb0s2aC9SQXJ6WXR4SUVONy9OckpvbnAwVFFkdkJLK0NO?=
 =?utf-8?B?LzBaSjhtRWZCeStnSVBWVFpwME82TEpMaUd4VGpyMkQ5Tmd2ejFKaExhUy9Z?=
 =?utf-8?B?MGZBU3JjRjAwQWgrcWhrQzBoamdIVDdJd3pSWHBhYnZ0YWEyUXVBUUxHYmxu?=
 =?utf-8?B?VVlYbW9Xak40Mms2SStmZFo0UzhxcUhxWlFZNm51RUxucmtnczFQWVAvNC92?=
 =?utf-8?B?YUZscjdqYkt1N3hWL0ZaRURzbzgwMGswNmN4NkNKS3lubzV0aXM3dzdUNnRn?=
 =?utf-8?B?ZDZEY2tESjBvbitNSUxuUzF1VlFzS0tFWUJzR0VmQkcwT3dpanE1THVCWHNL?=
 =?utf-8?B?QUl6YWExdklxSFZVRnhPc2lhYWlrTVZIZDBpb1BiK3pWZHhBWWhGc0x0ZGJD?=
 =?utf-8?B?aFY5aVBVQURxbFVjanQ1RUtTZmVmWXBnTDJ4eUtpWWdnV2J2R3A5dUhWbUR3?=
 =?utf-8?B?MUJqL2JPQXVXZk9na1ZwSjd4VlBMWURQemk0R3ViQitCZ0hGeTA5eXplTzZK?=
 =?utf-8?B?OVRqRTNHeld3NldsMmVOUVNDMHB0ME0wdWY5T25Ob2JVRjlURFdQTkpreUhi?=
 =?utf-8?B?RTczWkw5UlluczBoY0x1RWNhcGhVVDEwQ1ZMUzFoY2lPN1pyVTlyblcvT3hT?=
 =?utf-8?B?MmdFVUlhZXpsTTJ4TzJPVXpRc3VQdVh2SzltNE9OWmh1V3UxYkVQa2lQWGlL?=
 =?utf-8?B?V0Y1a0lnSDA3N2o0RkpWbXZrK0R6M3hjdlFqN0ZBZ05veDRpclhYdit4RWxB?=
 =?utf-8?B?Q202bUxDTEY3b3VNeUtjb1MxRGJzSDExZ3pGU1VOdWZrK1RnN1lPWEU1ZW5S?=
 =?utf-8?B?aGhpTXZlNEo3SUdaVVU3M3E5andvZHM1Y3VtbGRxWEFtbXpVeDZubmUwd1pJ?=
 =?utf-8?B?YW82cnIxbHNrOVRTenlkUC9IZXV6a3FqVU0vV3VqUno2Qm1DUVBFZDUwWlJv?=
 =?utf-8?B?SG45OFJ0Qno5M0hmMUYwa1AxbWw1WVk1YmVLSVhsd25YNUNDb2FCV2hyMUMz?=
 =?utf-8?B?V3V6L2c2NVRPcGplNTB0VUJWVDZNM21DcTRmNVhkc1NqbWNsL2Q3TWtEYkh3?=
 =?utf-8?Q?tEsp/VB8u2yhGb25HO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b500aee-05e3-42b1-cf9a-08dee692e4c1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 19:12:51.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVf4l0tWD/JojKbbsQlQZAFygabG9hlQIKUxQtA2golQKVCDQgSpR3wer/2+RkpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

On Mon Jul 20, 2026 at 5:56 AM EDT, Lian Wang wrote:
> Hi David,
>
> On 7/20/2026 10:44 AM, David Hildenbrand (Arm) wrote:
>> you give no real motivation and evaluation why this is required or
>> why this gives the user any benefit.
>> A SPLIT with an explicit order is not really want we want and it
>> does not fit the existing primitives.
>
> Thank you for the direct feedback.  Let me explain where this came
> from -- the cover letter should have included this context.
>
> This started from a real problem at Sangfor.  The scenario is:
>
>   KVM-QEMU virtualization on Kunpeng 920, with KVM guest memory
>   backed by tmpfs shared mappings (THP=3Dalways on the host).  An
>   Oracle database runs inside the VM.  DAMON monitors the KVM
>   process on the host to measure the hot-memory ratio.
>
>   The KVM process allocates and uses a large amount of memory.
>   Under the same workload, DAMON reports a significantly higher
>   hot-memory ratio with THP enabled versus THP disabled.  Direct
>   tmpfs write tests inside the VM -- touching at 4K and 2M
>   strides -- show a clear gap between the two cases.
>
>   DAMON parameters used:
>
>     operations=3Dvaddr
>     monitoring_attrs/nr_regions/min=3D500
>     monitoring_attrs/nr_regions/max=3D2000
>     monitoring_attrs/intervals/sample_us=3D500000
>     monitoring_attrs/intervals/aggr_us=3D20000000
>     monitoring_attrs/intervals/update_us=3D60000000
>     schemes/0/action=3Dstat
>     schemes/0/access_pattern/nr_accesses/min=3D1
>     schemes/0/access_pattern/nr_accesses/max=3Dmax
>
> The underlying issue is that under PMD-mapped THP, DAMON's monitoring
> granularity is coarser than the actual working set -- a single
> Accessed bit covers 512 base pages.  Before SJ's probe infrastructure
> arrives, there is a gap: DAMON cannot distinguish hot sub-pages from
> cold ones within a single THP.
>
> Split is one possible mechanism to bridge that gap -- by dismantling
> the PMD mapping, each base page gets its own PTE Accessed bit and
> DAMON recovers fine-grain monitoring.  It is not intended to be a
> permanent API, and certainly not "the opposite of collapse".

If you just want PTE level access bit information, why not split PMD
mapping instead of the THP itself?

In addition, the issue is about access monitoring granularity in DAMON,
why should user care and know about THP split operations? I would expect
DAMON detects the inability of getting fine grain access information and
split the PMD mapping itself instead of a user initiated DAMON_SPLIT. If
that is not possible with DAMON, an alternative is to provide something
more generic like DAMON_SAMPLE, which does the split under the hood,
instead of exposing MM internal operations.

>
> I did not write this scenario into the cover letter because our test
> results do not yet show a clear quantitative benefit worth claiming,
> and I did not want to oversell.  Without the context, I understand it
> looks like I randomly proposed a new primitive -- that was not the
> intention.
>
> SJ acknowledged [1] that the monitoring problem under THP is real.
> My RFC is a concrete proposal to start the discussion.  If split with
> an explicit order is not the right primitive, I would appreciate your
> thoughts on what the correct DAMOS abstraction for this should be.
>
> [1] https://lore.kernel.org/20260620203915.82947-1-sj@kernel.org/
>
> Thanks,
> Lian Wang




--=20
Best Regards,
Yan, Zi

