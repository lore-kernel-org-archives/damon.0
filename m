Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3C1A841E;
	Tue, 22 Apr 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343784; cv=none; b=i8qqJFKxehaUyrYdzI35IZz8u2pcDuDjtdp4W0/RlwEItmuqtTulND0wsM3oj1IcfQhW+pTPe2fiNV2RRxdGQ7jAs1+gJTyzi9pAlDJZtQCk3yIjh7cucTrRy3XrcQsu8yT81jJ7mppB6+j+LWSBcbYqmTygBAOdauWLAgJtus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343784; c=relaxed/simple;
	bh=F1mdJasUstpDuUqPhDFuWV/JlMqr9iPpRTPmyLpZmw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hy/Pz10sQo1gpamQHooZpqgs1kuFDEsCu+ERsL18ebjvX7h1s3jbTI+R59v8nScELAPHMO8NzyqyYAfirKhTMt6IzxVEh8HEPowwf1LMYWUTvX9tGMkUAQU3/3PfT5SQTmXzI6Y/nTZeycDsrUBHjUX/7Z+J2s1Kpf3P3bYWirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=freslzEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="freslzEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD7FC4CEE9;
	Tue, 22 Apr 2025 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745343784;
	bh=F1mdJasUstpDuUqPhDFuWV/JlMqr9iPpRTPmyLpZmw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=freslzEyg2R+LAGEbk8BZGGzb9DIft+3ss845IPqNqeLhDqmbjHwNe+I4+MlZxgBW
	 Q8Lf3MeY/kWfMrowLEWNWQgm7LKcH4+SU13cKTCP1j/5GNampA0q7rh6dwstIfl6dp
	 cWiavI13Yw0IopUiUlu3b/GzY+VGuZHnIxdJC/lkvGIB+5tTmLCvtjen3lWzs/vqXb
	 dPjqFkXJjQoSVAufUo5MQQx1Siz/tTXN0umfAVHS/ODn6QrW5Qzzq3jcMUvMFhyO4w
	 W8WgXSos51k9TJ9fqhmUB4BxKHyJAwMV/FctAAnWq0Q9/plH4Bd1vomS4IweIZRhYh
	 atxHrByRHIqJw==
From: SeongJae Park <sj@kernel.org>
To: zuoze <zuoze1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Tue, 22 Apr 2025 10:43:01 -0700
Message-Id: <20250422174301.58953-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <68043882-1878-4cca-a8fc-5e6cb9a88395@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 22 Apr 2025 19:50:11 +0800 zuoze <zuoze1@huawei.com> wrote:

[...]
> Thanks for the patches - I’ve noted the RFC series and user-space
> updates. Apologies for the delay; I’ll prioritize reviewing these soon
> to verify they meet the intended tracking goals. Appreciate your
> patience.

No worry.  Please take your time and let me know if there is anything I can
help.

I think we can improve the user-space tool support better for usability.  For
example, it could find LPAE case, set addr_unit parameter, and convert
user-input and output address ranges on its own.  But hopefully the current
support allows simple tests of the kernel side change, and we could do such
improvement after the kernel side change is made.


Thanks,
SJ

[...]
