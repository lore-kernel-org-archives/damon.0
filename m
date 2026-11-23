Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455506;
	b=IKScIcbnUx10JRq0RL1YdYOQ+866TWXnzigLrUqUMvHTBUkUvw3wCg7tPdbd58/v2/Iq
	 9f5cwHN+jlw6paPZwtg2/TfgMvrnna83QxzwdOgMrZRMzk78OqxNmbcHCU8SlPh/iu86R
	 Ttv1SytRNNOixq/CG63e2PYr42DQBUXxI0Fpmd+eG4DKXYwpXZwuBlzoOxskuMsVlvDbF
	 HkoTamp1aFkWyT/1YxU4nRjEqStgDmsM+7ufptax7LJTOgYqiIXgY8NOrRDpoVEkbDjtn
	 I9KE5BBZt35Vn8V+c/Go3dbz0nSZ8wY+hReTA4rZ0vkqVl6kyXazG3L6gH6wHJMh0EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=2hHNHNV+i9Jt1zfR9hkLZXtyIGw3mjVdQy4cVH5hgMY=;
	b=dlYD3/76AuIRpxJGgJL5M0ovRbJmrhapy28DAr07LCIPeK5qJ9fh4pDj4/b0bROqKwLM
	 XjOdto4xrhrwV+oICCCcZCE/EJeBp7ow8pH8zFdT9EIl9Su3FvESQk0Ij/hI8435eozQh
	 88aRwP61yfbMMzu6mEHKXbQw6+XlqOXKeaRbMZutw2KG9T3/gJyAvYvDwsMNm3NFNcWeE
	 zVBXpK6DJJPqU1j/HTy0h6Ddb/NO4+zQsZo4Ytjo26jUwiXyO2rvNChXOgSeBZhM/Ncal
	 ejE6Bom2sZM/OpoNLvYlW/pEhtEoes1qNzt1fK4s7LpumVV67VPPbj/AEQfngXC0+lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aNDOvkrC;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A6606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA1A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aNDOvkrC
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso856290eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455505; x=1796060305; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2hHNHNV+i9Jt1zfR9hkLZXtyIGw3mjVdQy4cVH5hgMY=;
        b=aNDOvkrCUmQniKJnQpR+KtAXVMs3wI7VZPI9QkhVtTWxpxS9/+dhrpcC2Tn0rajmZ9
         56n9bPRvjJd7imku16vq9R0o1bOrt4YIhD16/CqpL1sGznyWmdAVYJU19w2brXYKbwbP
         3JLjKH2UKJ4c/84h6dVthreJfge/1RVtYSDgiyGf9tovyXIREVQlmGU1ai082SBJvaZ5
         tCz04pfddQUJc4//zNtILtIF1BYuvRlTwDMRBidtQ34qwRKtj1n0KXK8Q9JovKVVweVA
         RcfuEVWCvr7gDwJsNnKfAgMm3txuD4ESl19LTbK3zF7UOwOi+fZjHinu6ySqoj6ieDFR
         ZDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455505; x=1796060305;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2hHNHNV+i9Jt1zfR9hkLZXtyIGw3mjVdQy4cVH5hgMY=;
        b=KHhMOqSFbwnWkqkgCRjfHErTBQJbW/UZV1+IDQEGWEljJl2Z2X9dHwhXkKKm5wFRFf
         tqaUgCUwAkM5DBLabs+XMaUMVexdf5y8nbb9FWaASqoVG1okXEhsE06vt6LWGZDUGE+M
         So60sL6LSMizfC8PPzMJBVKlUE98jCRYbAcxCLE6XMUmTsHGiq5YsGJgmI3lsrvVmpKi
         oi7aCtUneHbsZ1KzEzH4c6qn23cvyCTcy9glWWhG9gheIWcOGdwFjVpeperQLzX5W3Dl
         tRmETf2KD50be3WxFLVrlLuzvFrrEl43CqsJxKjDrOMOY7zwByTCw33gA4eGVf2gGB4c
         2TeQ==
X-Forwarded-Encrypted: i=1; AL+hErFRLFSfizjMD6+VrL2HI25Tjy698AFKUvwYgiKAbYvIVRAdo8lLabOs2eOFN0jLklBmo5qlDw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+GvjnaR7JGerU9tsM0n5eplBEqOOYkDfDkKtvXJ1ptsz3ET1a2
	r/UQ8oTu3bopWgYpTszd4Qz3QPOuZSx3f/XKNdtS1nxPDbXFw5pmzomnhuNCEfanZce0Sw==
X-Gm-Gg: AZFdTZfNP8mwbRue/WyatV7ay2eAusuMzNvA3kGWlde9GScwQ2RHcxfmy6XKCYg0ECO
	yteAOlun3pLkG/+fKrJU561WvGUuTNvlVrWGOGAhiHnWReleNNDl2u7U9iMAuqv8QDl5LsMnvMv
	M9cR8z67dOJgnnQrUPgEipW+YdzkyYxkp2qDzPnQGMLijgOjJCAE4yDofy2WzomEsBjPHoCGcYu
	XJpe45bEVGhC6rBlVIMm75wnGsTTXnZwHol7Uvh0HA41szTQe3LKQZZj0jJjlJ2WPWywVCWOHxO
	JcsnYkr6SzOTcf0K1uVfIw7k1apPeXw0OwVCol863YWRUiEV1N8vWqlJJ/OhDmMYT9nxYG3BVvE
	30kagIYkYVRPjz9+11Rozc/0XgRebCkdk9lXsP/QIQDp8y1Uvi6o3ag95Vpgt2NyBIIJB48ZJwF
	M86n5rpjOl+m6g0ZF470QyDEGjbSAF3MyRbJ5OLfMsv7qznb5BDXDUDnrOuGpE49sSNxIf8Ub5D
	oDXQIoy5xKcv3/g30s2Gi/5+h4Zd3gkX1B0SXtzaIcE7DEr0ucBpF6w/e7V2PQ5WgvWc5zj4IEb
	amMDCqMOnEIydTuv8pk3rPb5yCT08wfV1SUwUkL/qR8yNtashXvJ2DlqZFS/ClK+0/INAXvhfPp
	z3/PzpiVFMZDe71wyVvbCgUGZ9IKl+ulrFzYnzHRRQzL6Pf8kgChkjiJT0vF7Wg==
X-Received: by 2002:a05:7301:6405:b0:37a:cafa:6d78 with SMTP id 5a478bee46e88-3856ff54addmr14299630eec.33.1795455504821;
        Mon, 23 Nov 2026 09:38:24 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:38:24 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 22/27] mm/damon/sysfs: implement report producer
 addr_{start,end} files
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256490.4.3848004316312347610.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-23-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-23-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:06 -0800 SJ Park wrote:

> Implement addr_start and addr_end sysfs files under report producer
> directory.  Those set and get the address range of the user_report type
> data attribute reports.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
