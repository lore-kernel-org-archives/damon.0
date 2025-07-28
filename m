Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F5157A55
	for <damon@lists.linux.dev>; Mon, 28 Jul 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683418; cv=fail; b=P1LjhJ/LIDcGvOrWpzj2ZTowrCLa6lLv7eRGqKuTd6SPQ5Zj4HYAsZekL7kdThC6LRChlVupm9rRi4rIJJomR1VtengKOIIg2u2T2oPKft+NYSbDhjrMnar7OHtO2H68mG5Re92AMN1w87G6TF1DjhTPofHqfzYW+uD0Mg5D+Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683418; c=relaxed/simple;
	bh=yN5H7Q6iTKr4P8ftFwNKOlHr1uD7Xwu20E3AnctFRq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vhj/D1IfWRpCcUbEcg+hdamGZUlgcLIgGSF/INBgsc45GFqBJYrzj0MhY4UqqXNjTMTN9t2vaF99tB2fw3qwX6V2zQcwdqwFG580SRJudpF5jWzDPzokFGzdH3fsulm5Ls4MfXtiCMRSDaSukTILj0x7kdN7vg5P3GaDZ8TKbvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hL4hsHa/; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hL4hsHa/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZta8VEBVFHZr7eLmMTMkYUjfgJCsl9nifj93e4IrKd+YyOTDkxXK/GmanVgy/krKSlBBDhr5n9hYFU9Q+Q68shzhdtdyQl7Ca4cEnWiwg9wkZWrZ3F8R8/+2HuZ3U//hfHmwwaHPstf8Oj7TD5hrYIoz1yr8JQo5b0lbQ3B4dUfEjP6Wcy94flq7Y2s9pwhDiKLaQsRZq15VyYZMZ2rS77tQjVyB4igMkX4lURmcQQaSPMxWVe9DxU3lYzwP6Zv2HYzRSnqxR4WTmTymEgTkNc+1500KrEPfkv70neRafVFlo/7kvCqHXYndyGMqCxsEYnntgIG/jsxwNqsqbg0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PQTY8q4QfDnqBqQMyFugVtrUvoIsz0BxRY7MIknYCo=;
 b=K74BY7OKAPKJi2yqozDbSZzQM0EOIcClOhV3vamdgduOPkvSXebVBS0WkyIgRKnvOjI4NGs0U54uXA/FuQT7xaQnTupTdgEOuxoDSId+DBIUzHuPSHi8uTcD+3/At9NxxvB3/q+qfLivFzyOs0pvRg0z8+zwJTg7j1eU3zH+kKqY7Qfa/czifogIcBrYyzLARdZR3D+Ca5vSDN+7PGVTUw+AyPEWZY80pPlXzu8zoDd+OVCXjMnSjo8ZDaM1k3Fbhe8aame1iHq2MBnCZcrnGcmCFywYnm8p9lbvVI4F2z+7QWdgrIpI4GVwPisj1DDAdU8D7+5MrF2pgwmp0N0rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PQTY8q4QfDnqBqQMyFugVtrUvoIsz0BxRY7MIknYCo=;
 b=hL4hsHa/UCVuhTiTnW5d9iFvdQp2OUHhvYZEAZlnrd2cB4QTYMMBm5QpYT7P79U+bC69aWn3BtGGukv3alTOn0ChRpbtXw9j8hj1ZPo3zIKY+Suy8KAWGiylbLdB9sCSR3BZFnrSnuqg5Ht2J5PCwKSQDhZ2E7FtP233TbKg7dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Mon, 28 Jul
 2025 06:16:54 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:16:54 +0000
Message-ID: <cb9945fc-6f8e-4054-8116-d3f78e10dcb6@amd.com>
Date: Mon, 28 Jul 2025 11:46:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/vaddr: Skip isolating folios already in
 destination nid
To: Bijan Tabatabai <bijan311@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev
Cc: sj@kernel.org, akpm@linux-foundation.org,
 Bijan Tabatabai <bijantabatab@micron.com>
References: <20250725163300.4602-1-bijan311@gmail.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250725163300.4602-1-bijan311@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::8) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 740be125-57e5-4780-1e46-08ddcd9e5897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmg5bHY1c0QxMTBuall5WnMvbW1HaDV4djZMdm9CSCs1eHhOVVE1ZWdJWW5o?=
 =?utf-8?B?dENYMGJERU1BNFE5NFdQYWV3TzhwYURUc29rMzN4eGtrZXNRQ0cwL3p2U241?=
 =?utf-8?B?ckV4VDhteHdLTHE0ZHVRSkpUT1hCNDhISFZQR01mb3BzRnJRYWVCdEE4eTls?=
 =?utf-8?B?aUFrbmdvRWxta1h6enVEVmpST21iaW1zWWhERmFEQmp0S3A4M0pkV0tUMnY5?=
 =?utf-8?B?RUorQmhjSlRzQ1c4SzM2RFJlbWh3bk00VGY2c01lZG5wTEZpdE1mMWYwMzZJ?=
 =?utf-8?B?aHFyR2RYbCt5ckRkK1VWWVVFNTVncDR6MFdXYUFmZnorS0dQRmtqQTVvYW1w?=
 =?utf-8?B?b0pUSFNtQUV3YmpBUXBYWjlMdkpOL1c1ODl5RkxRQUpzNDJVbXlsTFhOOEZK?=
 =?utf-8?B?NE1IMVdFY0RrdEQ3cUxTZ3hJemJvaGtHU0VCdExwZkZhQU94UnE3STNGeE9T?=
 =?utf-8?B?WGpTYlZhdTVNdXhLbWZrVFNHSkoyQmdueTJ2aHZWTzJLUTdIci9wWkJyUnEr?=
 =?utf-8?B?NHptNmdWRldCbHU1WklkQ3FQcnMxTnhkMVpla2tSWnZjWCtCaTA0TTY2SGVw?=
 =?utf-8?B?RWIwMGM5TXJCUnpCTHlHZ0J3YWlDdXpjRFB1MWl6b3NuUVNaN25tb1orOVZG?=
 =?utf-8?B?ZFlaNzZrdldQeG9qTDVpNGYwM2FZR2JnQ3Bhb210NVhIN2xkNjBIVW92L2hQ?=
 =?utf-8?B?eW0wL25pUnY0TThFcndxbk9YQU0zcktMbzE0aVIvRUtoU2ZBVEZRM25HMjc1?=
 =?utf-8?B?YVRSV1hBYzk1Y0VQMkN6ZktGWmFZMUlyQjVnMWhLdHdIaFBha2Y4VStFRGtw?=
 =?utf-8?B?eVJMVDhrTGh1Y0tFU2lBOGxTdjhSaE9xK0FsKy9aYkVYRFFHRHZXVHpOZUdy?=
 =?utf-8?B?Q253amUxdzJqU2RDSXloczhUMHJUUVZ3RTlrallxMXVucEZrZ21yUXhVNFZT?=
 =?utf-8?B?bG12VXVOcHl2dGUyOU12MU9BbnpvTmJDNWFEd3k1SFFvNFpKVXFJSzFTUHFS?=
 =?utf-8?B?VG5iZ0JYYWFZbEhQbndRbjRoVWtiYlVVcmJwZ1dQdTdVcklta3oyZk1BS1Av?=
 =?utf-8?B?anA2bmo2WlNQRFYxaFNZQVM3RjFmNVgwQjc4TUx6dldLT3A2Z2NQNWxYbk5B?=
 =?utf-8?B?WG5HODgwZHpHRlovbmI4VEJSMERZT3E1V1J5SWkvT3FqOHBMVUpvWVNXR0dD?=
 =?utf-8?B?eTEwWWpXRTVPa29VMlRpb08wczRnYUpTbTRSTjlaRjBZRjk3Ty81MmRYSmhM?=
 =?utf-8?B?eFJKTFdQT1U4dHd5b05hdFJOamx4TGsyakdHOTFXLzFRVE0rb1NnVW5GcktG?=
 =?utf-8?B?Z21LMjBocUM3aldtVi8vMlc4ZjJBb1YwKzJ2TmFMK2Y1dmUyWVhTWnFpdXFH?=
 =?utf-8?B?TllKb0ZIUkNLSU1GNmsyVW91T2prRHJGbjcxWFVrSkl5N2JMQXROelE3K08z?=
 =?utf-8?B?bWdGaFNuUFZwMzRkNzdpaDNkSU5TWFh2c3RrdlpmZ2lWWml2dFZSWTJyaG5n?=
 =?utf-8?B?OXBYTE16dnZQZFlmUWU2LzQ0blJXZDFEc1RYN2lCcGIxTy9GYnBEMVpuRE91?=
 =?utf-8?B?L1FMWGt5cnFPUmZMdytwWThoNHNlWmRUV0drSWV3VWx5Q2pOSThqNjlZN0w1?=
 =?utf-8?B?NnRrQXJrbkR1Z3BjcDdFSUtDd1VwN2Jndk8zQTVnai9lWEo1aXBhWEZDYnNU?=
 =?utf-8?B?dkljQWxEbFhVZjVRUkFPanh1em9jTWZKeUFXeUc5NXArVU1vT1dVUDhLOVZ3?=
 =?utf-8?B?bm5nSlZMTGVFMjcyRXdhVUR6U0JjTzVpd3E1c1BRV3MyWE1lNTJFei9wSFdK?=
 =?utf-8?B?MFRWMDdyYmdsam9mMWw3N0syb1Q5VDEzR0NOaEJBOFFRYXM4RFRUOXNTb0Nl?=
 =?utf-8?B?MEgxUnpXQ2tTaTN5OGdRYWMxVjhBelVFWTI3eDZuSy9XMGlkWWxVRHFqamU3?=
 =?utf-8?Q?TCJKEOzXOY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVNhNnJydkE4RVRiM0R1VjJqTWFCRnFQMitGOTVrUjNoZ3Z4SkdNVmF0a2tH?=
 =?utf-8?B?clhnc0d1cFhaWGp2UEZja2N0UnhWNUFmRjlqZDNtMUtpWnl6RGFTNkZubVJJ?=
 =?utf-8?B?enY2UFRhWkNXTUh6T0krcnJmWDIrTERBcUlTUFRCZUJ0RTNPMjU4K1pUa2FX?=
 =?utf-8?B?enpUYTRHZlBMeTRlaHh4RnJoOTlHODhualJCWjIyNGg4OCs5a2Qwa3d5YjN6?=
 =?utf-8?B?akIwOEdXc1pLWUhxMFo4YkF5VHM5YU1uaFlpYlljckNhUVRGNUlsY1UvbFNT?=
 =?utf-8?B?ZDhuWmczL1d1UGZzR3dHcm11V2tvRHB4UWhLVWRWSlBiUUhkNUJMc1lERFg1?=
 =?utf-8?B?U3NuNG9ZR1VsMjdSVUhQTGtHTlZSYnE5a2E2QzhaelplQzByaEl4bTQzVWZt?=
 =?utf-8?B?cnM2WkVKVDhhUzhEYVFtb3dMdkF6ZFJ3NDdPT1RXSHFpS0RweHpRMnA0Mjky?=
 =?utf-8?B?MTkxaEpBOUR6ZmZVZjYyVWNPYndXdTdCMVRGaW03a29UYTkrOGFjTkhWYW5G?=
 =?utf-8?B?NDZBOGhEOEZSTkd2a0VnNWd6UlpOMWRhL1NtY1FFSngwL3RXb25pOEJwZEZF?=
 =?utf-8?B?YmNWYmN0K0RTM3o1L1FINC9KS0M5RlM1bk9vSzd0eVhOWDk0VzNwRUF5QTVD?=
 =?utf-8?B?WTJQb3NuWmRVYjRTV2RXRGRzVGJXM3ljWEJrdUNVWW0xUnRQSDJJcEx3VnpD?=
 =?utf-8?B?UXo0UDNjc3pKWmVRbVF3ZEpHcU92S1dDWTJLb0IxajloUHJ5dnNNMUF0MDdF?=
 =?utf-8?B?M0FmNGF6RlQvK3ZCV0RwVEpuUVJjTGlXbXlZOThTUkcvd0RNd0NzalFYaTl5?=
 =?utf-8?B?empidmhmN0VHRUQ3N1NtaUJCbFpxajc1blp0d0kydVlndFpmSHZLbWRGVi90?=
 =?utf-8?B?L1FkMEsvTEZkVGdTeHgrRDAvRk83Ymh6UzZjME5BaUY4N3FTdWJlalQvU2d5?=
 =?utf-8?B?U28rQmJYbTVDUmNuU3dDV25jZEdGaG9NaVhVbk5hcEJtdlJOSFJqcmE2NlR3?=
 =?utf-8?B?Z3FWTy9vV2dPL09yUDdTc3F6b1ppbjc4YVVTQ1E2Wldkb1lMQnhqUU44Ny9D?=
 =?utf-8?B?cDdSZ2xjMGlqQXFsY0J4aVd6L2QxcDI3eWo2VFlGc29mM3BZQ2M4b1hXRXlP?=
 =?utf-8?B?NlZPMlFzRU5tSGMxSDk2NlNaMVNGWnltaDF6MHFZSTNldjNmb21GeFoyL2pz?=
 =?utf-8?B?R0t1SXdnUmg5bGF6QjVqdHZnNWlpWWhLR01GUFQ1OFk3QUhKazlHTXl1cUhB?=
 =?utf-8?B?WVFSeEhkcFhMT0xTcXF2QTNnTGxsUmJLYmpXR21XaG4xR2JWTXNxY05XWGEr?=
 =?utf-8?B?ZGNuQ0tlSHgyblY1K1ZTd0J1d09pOUdlU1F4ZjIzWHFqVVIyempkdllZODUw?=
 =?utf-8?B?RlBCWjdRNHJwVzBSZW10OURzYTlIaGFsQlNMeStXQnh4YVR6blptTm9QUUhu?=
 =?utf-8?B?MGdhYkI2ajlWVkRGVjB5Ync3bWtHbEU3ai9KaFdyV2ErdXYzTmtES0wzWXYz?=
 =?utf-8?B?Z0M3ODAxZXF3cWVSaGVLZ2Y3ZktmT0FTakdpQTNPWFVsWHpYa0tZcEJYcjRN?=
 =?utf-8?B?L25ERXdsRTk3MkdXc2V3Vis0aHJyTmxFOWFpalRKRTRUc3BhVXV4UEZLeVZp?=
 =?utf-8?B?V1Fsb05CN2FIWVZHbUFmTUVmNTVJVnM4b0RkMmcxbU9OaE5NV1N5S0UyQ2FB?=
 =?utf-8?B?VjZKSm5kR1V3Qlp3RUZJallsOU8wM01PbU8vL0RPU0FZa0E1ZkxKVUQwcUpw?=
 =?utf-8?B?MjdZaVByU2EvSUlYVE5HV3ROQW13RkRHWHpzQzNlL0NFbitQMFN4TDYrRVph?=
 =?utf-8?B?Zm9WVThXRG9adEVpeG1iT0FVWHMwbEtGYWVIL29uVEVNZ0RNRHFyTzhxY2tp?=
 =?utf-8?B?UE8vMnRQZkNrUjlQV1NZN1NiTG1lNDFkeGlRT20xanNvcGpxNzlGY0x5OEJX?=
 =?utf-8?B?STBUb1VSYmgvVnNtRWVoWHRzUFp5bDhQUHgyaEtkTEtWR3JFY0R4K2JOYTRS?=
 =?utf-8?B?QUlqcXQ3T2lzWDhJaFhjODRxZEhhMmVHQ0tNbE9IOFo1ZHZLdERHL1hPa01N?=
 =?utf-8?B?Znp2czErT1dyQzhPM3E0KyswN21aUStYQWJXTGozODZFenJBTXp4UXhTZlZh?=
 =?utf-8?Q?dD4XJiegjkPlOvgm/S/VhLXry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740be125-57e5-4780-1e46-08ddcd9e5897
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:16:53.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKsJQ8mcGVk50tUqQXx1y2M0Y+4wLV0RUp+VTGD36e1deHnwPMIbwh/izSUCq8+Youw3v7EQcLFcOPM+xZq7dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

On 7/25/2025 10:03 PM, Bijan Tabatabai wrote:
> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> damos_va_migrate_dests_add() determines the node a folio should be in
> based on the struct damos_migrate_dests associated with the migration
> scheme and adds the folio to the linked list corresponding to that node
> so it can be migrated later. Currently, folios are isolated and added to
> the list even if they are already in the node they should be in.
> 
> In using damon weighted interleave more, I've found that the overhead of
> needlessly adding these folios to the migration lists can be quite
> high. The overhead comes from isolating folios and placing them in the
> migration lists inside of damos_va_migrate_dests_add(), as well as the
> cost of handling those folios in damon_migrate_pages(). This patch
> eliminates that overhead by simply avoiding the addition of folios that
> are already in their intended location to the migration list.
> 
> To show the benefit of this patch, we start the test workload and start
> a DAMON instance attached to that workload with a migrate_hot scheme
> that has one dest field sending data to the local node. This way, we are
> only measuring the overheads of the scheme, and not the cost of migrating
> pages, since data will be allocated to the local node by default.
> I tested with two workloads: the embedding reduction workload used in [1]
> and a microbenchmark that allocates 20GB of data then sleeps, which is
> similar to the memory usage of the embedding reduction workload.
> 
> The time taken in damos_va_migrate_dests_add() and damon_migrate_pages()
> each aggregation interval is shown below.
> 
> Before this patch:
>                         damos_va_migrate_dests_add damon_migrate_pages
> microbenchmark                   ~2ms                      ~3ms
> embedding reduction              ~1s                       ~3s
> 
> After this patch:
>                         damos_va_migrate_dests_add damon_migrate_pages
> microbenchmark                    0us                      ~40us
> embedding reduction               0us                      ~100us
> 
> I did not do an in depth analysis for why things are much slower in the
> embedding reduction workload than the microbenchmark. However, I assume
> it's because the embedding reduction workload oversaturates the
> bandwidth of the local memory node, increasing the memory access
> latency, and in turn making the pointer chasing involved in iterating
> through a linked list much slower.
> Regardless of that, this patch results in a significant speedup.
> 
> [1] https://lore.kernel.org/damon/20250709005952.17776-1-bijan311@gmail.com/
> 
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> ---
> Sorry I missed this in the original patchset!
> 
>   mm/damon/vaddr.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 7f5dc9c221a0..4404c2ab0583 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -711,6 +711,10 @@ static void damos_va_migrate_dests_add(struct folio *folio,
>   		target -= dests->weight_arr[i];
>   	}
>   
> +	/* If the folio is already in the right node, don't do anything */
> +	if (folio_nid(folio) == dests->node_id_arr[i])
> +		return;
> +

I have seen good improvements with similar changes in PTE A bit scan
based patches.

Feel free to add

Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>

>   isolate:
>   	if (!folio_isolate_lru(folio))
>   		return;

