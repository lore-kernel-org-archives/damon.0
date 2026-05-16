Received: from outbound.mr.icloud.com (mr-2005e-snip4-8.eps.apple.com [57.103.71.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDA3932EF
	for <damon@lists.linux.dev>; Sat, 16 May 2026 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.71.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778973283; cv=none; b=d3t808fHCZfa2ykUTgWr+y2mnyFjhj4lONXRHuWHh0WC8RPqcUebw7j6bEoSZuIHz2+9FNMngn9qtWKIvnXWWezAfO37aFUUlCoYiht3MXrvROdnfVlnbqhMuzr6irr+CjBpyKsrPdMqpQcsp2OKQ4lxRYWKZkEaeq3JvpW62Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778973283; c=relaxed/simple;
	bh=L/JTUTY0j5GARu9gVX6D1m0HdMb+0VJudBrgr89NJy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZJcz3w/3ey7vY27PVylyqWPJ0KDmc6ry+5xZTVlg+VrOfy8U2neJLzfQGJLqnLJqORZvOTNZH4OJLPQwmTEVH3AK7gzUORf+GOgH8i4Rk3UGw5p1dUtiTZTYLTRnr2uNcg26E4h/MQQrLO9C+sKu4U7+hjMILRQhmqpEmDc3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yMeRoyrm; arc=none smtp.client-ip=57.103.71.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yMeRoyrm"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPS id E96FD180014F;
	Sat, 16 May 2026 23:14:40 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEG1sIUhhXE1gTVl8OXQIwUBtfAkIPHBNWFRMLU1ZRGFwdQAhUClkVC0EFXXcCURxWDVdDVARfUEsbDlwCS1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1JXEQpJAl0BRgtDXEweWVQJUF1bTQULGg9XR1obVgsFXwQVXzhaDlsERxQXG1wACUtGCUkdDgRUB10FXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778973281; x=1781565281; bh=/zVePlSPbB8tZaMeUqvI5r7tySGsEW1UJvhXgOHkLv8=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=yMeRoyrmKaBhjYKor1AW72OHUCOd+ptW0mkDPf04aBLfg/B1SSbV77JJB7mK0CEZhgokRf/xylM2NW6cGi4ktDRx9f59Kq4oE5XOIW5jLY+Z4xKuQlY+SToBkrBtSAxpd3iG8EYmqS7oL7ldnQoIc4u1jzLtwtWxyv59KLcI+8oTGS4RC+MA2e7GmDZ+jVX0I4v9wk8xgbr6NPZneK2ESRA0mmyXZbLbagJXt+H4no+MLUESCGzT+DX1ppi6YocxtX/IEBiEj54DhnU0JYoO/3j3sPETdsGrEFvKTPtk4St873tCP3L+/6rt+3qMYGpmwGEZpucur7AWbOwNuhAOig==
Received: from [192.168.1.33] (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPSA id 788201800146;
	Sat, 16 May 2026 23:14:37 +0000 (UTC)
Message-ID: <9ea31106-93e4-4cbb-b56f-de7ccef246ef@icloud.com>
Date: Sun, 17 May 2026 08:14:35 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix typos in design.rst
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260516170847.146524-1-sj@kernel.org>
Content-Language: en-US
From: Cheesecake <cheesecake2960@icloud.com>
In-Reply-To: <20260516170847.146524-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pixu_aVUBLdvevj9Cz3LevPRO61nP8sx
X-Authority-Info-Out: v=2.4 cv=bcFmkePB c=1 sm=1 tr=0 ts=6a08fa61
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=sIGCgqHK338A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8 a=JORHhQuN_TVeFzD3vIAA:9 a=QEXdDO2ut3YA:10
 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDIzNyBTYWx0ZWRfXzpv8BHIlWj63
 3jfaMPHcz/h7PH3Pu0ibIXpZvtyeE/o0A5D3rC+YmTWAkqiP0Lwrr1jxy8xTs3sHZzxzdKvFG3a
 CbovpU3V2hljm3X7DQHlePJeDkmfFARTS5sK9NYNEm0sT6UlUTtJsodikIO1SxVVdHbvX1H5in3
 kXlO1cB+RO1MKA/HiE1tff6ScgNqzVhDPmR2h2MluZ90NDjb21/W0gt3rMtatB/kkLfABTqcual
 1n+MBnFD+AwBi76GHZ4W3Tvn5Bf2AtSjzv0ZgqfnN7vdhCjFNf801vgFZCPWHiappA4wX0xQYKv
 2lvzZVJQBeM30lG8NiqaNIIrjAhRLeIb60yz81KvGv5pNR8Mr4HvrvB2CUXwcQ=
X-Proofpoint-GUID: pixu_aVUBLdvevj9Cz3LevPRO61nP8sx


On 2026/05/17 2:08, SeongJae Park wrote:
> Hello Cheesecake,
>
> Thank you for this patch!
>
> For the consistency, let's use 'Docs/mm/damon/design:' as the prefix of the
> subject.  E.g., Docs/mm/damon/design: fix three typos
>
> On Sat, 16 May 2026 18:35:37 +0900 Cheesecake <cheesecake2960@icloud.com> wrote:
>
>> L140: "unsinged" -> "unsigned"
>> L371: "sampleing" -> "sampling"
>> L387: "multipled" -> "multiplied"
> Thank you for finding and fixing these!
>
>> Signed-off-by: Cheesecake <cheesecake2960@icloud.com>
> Is Cheesecake your real name or known identity?  We don't allow anonymous
> contributions [1], and mm community prefer to use real names.
>
> [...]
>
> The file changes look good.
>
> Could you please send v2 of this patch with changed subject and the name (if
> Cheesecake is not your real name or known identity)?
>
> [1] https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
>
>
> Thanks,
> SJ

Thanks for pointing that out.

I accidentally sent this patch using an anonymous address/name.
I'll resend it properly later.

Thank you for your time.

