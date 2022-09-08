Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3A7C
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 00:04:50 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id y82so15757473yby.6
        for <damon@lists.linux.dev>; Wed, 07 Sep 2022 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CSfIoIEprQL1Zq/RCJabpgauZviYxw0dabcud5lCVXU=;
        b=PKwHKJ7dTQ+Ce4MqDAqBwUG9HShjVfeph8EZCcyG/8suM34nxJ5wffutIH1zst93HE
         IQ6A+vW0zNStaCdrsf7qswV/pKV9wcsZH6LmaW0dmvasKWzbKbpg3MZfTFofSTMFi857
         /5OLLjfjaDOjsStv8l3klvJCkLf9jpzfTth3tuAxxXqn94Ffdqf7IKiqnSZVLD5qqTzj
         ZaG97PXga8YP5KdW5MwINtZRpye48FJ0+ymw4qn3XIEqeKXfoKCYrWYqjwBRvAluYPcB
         MnDN1bCITQC6ecInQhEMgj39QF2ZahGKweg8QsHhYHQglfpwpf2bvpEBfQHNlXZui95j
         IVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CSfIoIEprQL1Zq/RCJabpgauZviYxw0dabcud5lCVXU=;
        b=zAQwGFalq/+vlB+M2sZVBaGxZClvLrRiwlTUjh73+YJfUhcRuqlezSAiir96/cvUwr
         ouNbKRu2Q4g5Ytj0sbuOo8zy/VcRqZIKEv8vH86UOlmwOwgn6ip+PTYmC9KFk7DB94PO
         YidE6L67oQFGkvRIUjOYzWfXaJhUs3a9f7C2QuxXyWNWB6o1rXYt5xBqSQ5mW522IuQR
         F5P3MlTqbSZBdO8VLRgvfoWeIb/BnVzd1bDJDq0Px1kdxzGxsPJmIADtN4bQvR1GfzcV
         g4OwDr+j9uMilk9Hkl8chNab+50tP4X81zp9Qplp6vsUOxOqa29x5aZADBtUfPN0M58P
         uRZA==
X-Gm-Message-State: ACgBeo1FmLc3lV47xEPe6s9vhDLiV7F2hYI2TpT/hTUchwvYwabLBjL0
	yMFWLu9P562aOLK2lTk/oWhnAPumzQ66v8I0YgLXywha
X-Google-Smtp-Source: AA6agR5OQMJab5Hu4Ov4v7wHMb1Y1JB/UM8qIplqhL3II3ijM4vkZFmwyS6oDCWDHtPUhAqJWkmUE6RTMJRl/EMz1aU=
X-Received: by 2002:a25:9948:0:b0:67b:fc24:642d with SMTP id
 n8-20020a259948000000b0067bfc24642dmr4661289ybo.42.1662595489484; Wed, 07 Sep
 2022 17:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAM7-yPSeNe9v4QGRoqXkjcLtio3xiJKha9bRoPiu7v=o3RG2Nw@mail.gmail.com>
 <20220907163525.78126-1-sj@kernel.org>
In-Reply-To: <20220907163525.78126-1-sj@kernel.org>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 8 Sep 2022 09:04:38 +0900
Message-ID: <CAM7-yPRgE58_BgAmkYuvWLHmLu2N2Ff_9nxHcpzEggvajkLj0w@mail.gmail.com>
Subject: Re: [Question] About damon_set_regions function.
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> Thanks.  If you don't mind, I will post a patch for this soon.

Never mind! I'm looking forward to seeing the patch :) Thanks!


-- 
Best regards,
Levi
